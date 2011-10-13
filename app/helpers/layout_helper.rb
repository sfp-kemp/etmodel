module LayoutHelper
  
  def title(str)
    haml_tag :h2, str
  end
  
  # splits the collection in two and adds a read more link if 
  # the collection.length > limit
  # takes a block that yields all elements of the collection
  #
  def readable_collection(collection, limit, &block)
    first_half = collection[0..limit]
    second_half = collection[limit..collection.length]
    first_half.each do |item|
      yield item
    end
    
    unless second_half.blank?
      # generate a unique id
      collection_id = "readable_collection_" + (Kernel.rand * 100000).to_i.to_s 
      haml_tag :a, t('show_more'), :href => "javascript:$('##{collection_id}').toggle()", :style => 'display:block'
      haml_tag :div, :id => collection_id, :style => 'display:none' do
        second_half.each do |item|
          yield item
        end
      end
    end
  end
  
  # Cuts the text to the desired length and adds a js-enabled more link
  def smart_truncate(text, opts = {})
    return nil unless text
    opts.reverse_merge!(:length => 80)
    return text unless text.length > opts[:length]      
    short = content_tag :span, truncate(text, :length => opts[:length]), :class => '_truncated'
    long  = content_tag :span, text, :class => '_original', :style => 'display: none'
    link  = link_to_function I18n.t('more_text'), '$(this).siblings("._original").show();$(this).siblings("._truncated").hide();$(this).hide()'
    out   = short + link + long
    out.html_safe
  end

  # TODO move controller_name logic to Tab
  def tab(title, controller_name = title, action_name = nil)
    class_name = (controller.controller_name == controller_name) ? 'active' : nil
    if action_name.nil?
      link = "/#{controller_name}"
    else
      link = (controller_name == "") ? '/' : "/#{controller_name}/#{action_name}"
    end
    haml_tag :li, :class => class_name, :id => title.downcase do
      haml_tag :a, I18n.t(title.capitalize), :href => link
    end
  end

  def search_result_description(result)
    if d = result.andand.description
      if d.content.present?
        "#{strip_html d.content[0..160]}...".html_safe
      end
    end
  end

  def back_to_model_link
    if Current.setting.last_etm_controller_name.blank?
      link_to t("Home"), "/"
    else
      link_to t("back to model"), :controller => Current.setting.last_etm_controller_name, :action => session[:last_etm_action_name] 
    end
  end
  
  
  def shadowbox(&block)
    haml_tag :div, :id => "shadowbox-outer", :style => "width: 70%; margin: 10px 0px 40px 15%;" do
      ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'].each do |dir|
        haml_tag :div, :id => "shadow-bg-%s" % dir, :class => "shadow-bg"
      end
      
      haml_tag :div, :id => "shadowbox-inner" do
        haml_tag :div, :id => "shadowbox-content", :style => "width: 100%; float:none;" do
          yield
        end
      end
    end
  end
  
  def current_tutorial_movie
    SidebarItem.find_by_key(params[:id]).andand.send("#{I18n.locale}_vimeo_id")
  end
  
  def country_option(code, opts = {})
    current = Current.setting.region == code
    selected = current ? "selected='true'" : nil
    %Q{<option value="#{code}" #{selected}>#{I18n.t(code)} #{"(test)" if opts[:test]}</option>}.html_safe
  end
  
  def percentage_bar(item)
    unless item.percentage_bar_query.blank?
      # need client for showing % bars
      if client ||= Api::Client.new
        client.api_session_id = Current.setting.api_session_id
      end
      val = client.simple_query(item.percentage_bar_query)
      # multiplied by 90 because of interface limits, there should be some space left for the value
      haml_tag :span, :class=>'bar',:style => "width: #{(val * 90).round(2)}%", :alt =>"#{t("sidebar_item.alt")}"
      haml_tag :span, :class=>'value',:style => "left: #{(val * 90).round(2)}%" do
        haml_concat "#{(val * 100).round}%"
      end
    end
  end
end
