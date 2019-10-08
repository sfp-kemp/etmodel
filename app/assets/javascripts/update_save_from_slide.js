// This is kind of hacky but it enables to the inside of the tab to link.

 function updateSaveFromSlide(){
  // Do nothing if active_saved_scenario_id isn't available.
  if(!globals.settings.active_saved_scenario_id){ return null }

  var saveLink = document.getElementById('save-from-slide');
  saveLink.href = '/scenarios/' + globals.settings.active_saved_scenario_id
  saveLink.classList.remove('button--disabled')
}
