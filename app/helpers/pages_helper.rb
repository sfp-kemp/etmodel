module PagesHelper
  def scenario_year_select
    year_choices = ((Time.now.year)..2050).to_a.map { |i| [i, i] }
    default_year = Current.setting.end_year || year_choices.last.last

    html_options = options_for_select(year_choices, default_year)

    select_tag(:end_year, html_options)
  end

  def intro_movie_url(movie)
    movies = {
      true  => { how: 15661126, what: 15765569 },
      false => { how: 15663129, what: 15660970 }
    }

    "https://vimeo.com/#{ movies[english?][movie] }"
  end

  def area_status_suffix(area)
    if status = area.status
      "<span class='#{ status }'>
        #{ t("area_states.#{ status }") }
      </span>".html_safe
    end
  end
end # PagesHelper
