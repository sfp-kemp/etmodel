class UpdateApiKeys < ActiveRecord::Migration
  def self.up
    execute "UPDATE input_elements SET `key` = 'households_replacement_of_existing_houses' WHERE `id` = 1;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_fridge_freezer_electricity_efficiency' WHERE `id` = 6;"
    execute "UPDATE input_elements SET `key` = 'costs_oil' WHERE `id` = 11;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_wind_onshore' WHERE `id` = 12;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_wind_offshore' WHERE `id` = 14;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_combustion_gas_plant' WHERE `id` = 16;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_combustion_oil_plant' WHERE `id` = 17;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_combustion_coal_plant' WHERE `id` = 18;"
    execute "UPDATE input_elements SET `key` = 'agriculture_chp_supercritical_wood_pellets' WHERE `id` = 19;"
    execute "UPDATE input_elements SET `key` = 'households_lighting_efficient_fluorescent_electricity_share' WHERE `id` = 43;"
    execute "UPDATE input_elements SET `key` = 'households_lighting_led_electricity_share' WHERE `id` = 44;"
    execute "UPDATE input_elements SET `key` = 'households_solar_pv_solar_radiation_market_penetration' WHERE `id` = 47;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_solar_thermal_share' WHERE `id` = 48;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_micro_chp_network_gas_share' WHERE `id` = 51;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_electricity_share' WHERE `id` = 52;"
    execute "UPDATE input_elements SET `key` = 'costs_coal' WHERE `id` = 57;"
    execute "UPDATE input_elements SET `key` = 'costs_gas' WHERE `id` = 58;"
    execute "UPDATE input_elements SET `key` = 'costs_biomass' WHERE `id` = 59;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_water_river' WHERE `id` = 114;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_water_mountains' WHERE `id` = 115;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_water_blue_energy' WHERE `id` = 116;"
    execute "UPDATE input_elements SET `key` = 'om_costs_nuclear_nuclear_plant' WHERE `id` = 121;"
    execute "UPDATE input_elements SET `key` = 'om_costs_wind_onshore' WHERE `id` = 126;"
    execute "UPDATE input_elements SET `key` = 'om_costs_wind_offshore' WHERE `id` = 127;"
    execute "UPDATE input_elements SET `key` = 'om_costs_water_river' WHERE `id` = 129;"
    execute "UPDATE input_elements SET `key` = 'om_costs_water_blue_energy' WHERE `id` = 130;"
    execute "UPDATE input_elements SET `key` = 'om_costs_water_mountains' WHERE `id` = 131;"
    execute "UPDATE input_elements SET `key` = 'om_costs_earth_geothermal_electricity' WHERE `id` = 132;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_solar_solar_panels' WHERE `id` = 133;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_solar_concentrated_solar_power' WHERE `id` = 134;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_nuclear_nuclear_plant' WHERE `id` = 136;"
    execute "UPDATE input_elements SET `key` = 'costs_co2' WHERE `id` = 137;"
    execute "UPDATE input_elements SET `key` = 'costs_co2_free_allocation' WHERE `id` = 138;"
    execute "UPDATE input_elements SET `key` = 'om_costs_co2_ccs' WHERE `id` = 139;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_co2_ccs' WHERE `id` = 140;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_car_kms' WHERE `id` = 141;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_truck_kms' WHERE `id` = 142;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_trains' WHERE `id` = 143;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_planes' WHERE `id` = 144;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_ships' WHERE `id` = 145;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_electricity_share' WHERE `id` = 146;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_diesel_mix_share' WHERE `id` = 147;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_diesel_mix_share
' WHERE `id` = 148;"
    execute "UPDATE input_elements SET `key` = 'transport_truck_using_gasoline_mix_share' WHERE `id` = 157;"
    execute "UPDATE input_elements SET `key` = 'transport_truck_using_diesel_mix_share' WHERE `id` = 158;"
    execute "UPDATE input_elements SET `key` = 'transport_truck_using_electricity_share' WHERE `id` = 159;"
    execute "UPDATE input_elements SET `key` = 'industry_useful_demand_electricity_efficiency' WHERE `id` = 169;"
    execute "UPDATE input_elements SET `key` = 'industry_useful_demand_useable_heat_efficiencty' WHERE `id` = 170;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_electricity_efficiency' WHERE `id` = 171;"
    execute "UPDATE input_elements SET `key` = 'policy_area_onshore_land' WHERE `id` = 178;"
    execute "UPDATE input_elements SET `key` = 'policy_area_onshore_coast' WHERE `id` = 179;"
    execute "UPDATE input_elements SET `key` = 'om_costs_combustion_gas_plant' WHERE `id` = 180;"
    execute "UPDATE input_elements SET `key` = 'om_costs_combustion_oil_plant' WHERE `id` = 181;"
    execute "UPDATE input_elements SET `key` = 'om_costs_combustion_coal_plant' WHERE `id` = 182;"
    execute "UPDATE input_elements SET `key` = 'om_costs_combustion_biomass_plant' WHERE `id` = 183;"
    execute "UPDATE input_elements SET `key` = 'costs_uranium' WHERE `id` = 185;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_diesel_mix_efficiency' WHERE `id` = 186;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_ships_efficiency' WHERE `id` = 187;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_planes_efficiency' WHERE `id` = 188;"
    execute "UPDATE input_elements SET `key` = 'policy_area_roofs_for_solar_panels' WHERE `id` = 193;"
    execute "UPDATE input_elements SET `key` = 'policy_area_land_for_solar_panels' WHERE `id` = 194;"
    execute "UPDATE input_elements SET `key` = 'policy_area_land_for_csp' WHERE `id` = 195;"
    execute "UPDATE input_elements SET `key` = 'policy_area_biomass' WHERE `id` = 196;"
    execute "UPDATE input_elements SET `key` = 'policy_area_green_gas' WHERE `id` = 197;"
    execute "UPDATE input_elements SET `key` = 'policy_sustainability_co2_emissions' WHERE `id` = 198;"
    execute "UPDATE input_elements SET `key` = 'industry_useful_demand_network_gas_non_energetic' WHERE `id` = 202;"
    execute "UPDATE input_elements SET `key` = 'households_useful_demand_electricity_per_person' WHERE `id` = 203;"
    execute "UPDATE input_elements SET `key` = 'households_useful_demand_for_cooling' WHERE `id` = 204;"
    execute "UPDATE input_elements SET `key` = 'industry_useful_demand_crude_oil_non_energetic' WHERE `id` = 205;"
    execute "UPDATE input_elements SET `key` = 'policy_dependence_max_dependence' WHERE `id` = 206;"
    execute "UPDATE input_elements SET `key` = 'policy_cost_electricity_cost' WHERE `id` = 207;"
    execute "UPDATE input_elements SET `key` = 'policy_cost_total_energy_cost' WHERE `id` = 208;"
    execute "UPDATE input_elements SET `key` = 'policy_grid_baseload_maximum' WHERE `id` = 210;"
    execute "UPDATE input_elements SET `key` = 'policy_grid_intermittent_maximum' WHERE `id` = 211;"
    execute "UPDATE input_elements SET `key` = 'policy_dependence_max_electricity_dependence' WHERE `id` = 212;"
    execute "UPDATE input_elements SET `key` = 'industry_useful_demand_electricity' WHERE `id` = 213;"
    execute "UPDATE input_elements SET `key` = 'industry_useful_demand_useable_heat' WHERE `id` = 214;"
    execute "UPDATE input_elements SET `key` = 'industry_burner_network_gas_share' WHERE `id` = 216;"
    execute "UPDATE input_elements SET `key` = 'industry_burner_crude_oil_share' WHERE `id` = 217;"
    execute "UPDATE input_elements SET `key` = 'industry_burner_coal_share' WHERE `id` = 218;"
    execute "UPDATE input_elements SET `key` = 'industry_burner_wood_pellets_share' WHERE `id` = 219;"
    execute "UPDATE input_elements SET `key` = 'agriculture_electricity_demand' WHERE `id` = 220;"
    execute "UPDATE input_elements SET `key` = 'agriculture_heat_demand' WHERE `id` = 221;"
    execute "UPDATE input_elements SET `key` = 'agriculture_burner_crude_oil_share' WHERE `id` = 223;"
    execute "UPDATE input_elements SET `key` = 'agriculture_heating_biomass_fired_heater_share' WHERE `id` = 225;"
    execute "UPDATE input_elements SET `key` = 'agriculture_heatpump_water_water_ts_electricity_share' WHERE `id` = 227;"
    execute "UPDATE input_elements SET `key` = 'agriculture_geothermal_share' WHERE `id` = 228;"
    execute "UPDATE input_elements SET `key` = 'other_useful_demand_electricity' WHERE `id` = 229;"
    execute "UPDATE input_elements SET `key` = 'other_useful_demand_useable_heat' WHERE `id` = 230;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_combustion_waste_incinerator' WHERE `id` = 231;"
    execute "UPDATE input_elements SET `key` = 'om_costs_combustion_waste_incinerator' WHERE `id` = 232;"
    execute "UPDATE input_elements SET `key` = 'policy_area_offshore' WHERE `id` = 233;"
    execute "UPDATE input_elements SET `key` = 'policy_sustainability_renewable_percentage' WHERE `id` = 234;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_lpg_share
' WHERE `id` = 238;"
    execute "UPDATE input_elements SET `key` = 'transport_car_using_compressed_natural_gas_share
' WHERE `id` = 239;"
    execute "UPDATE input_elements SET `key` = 'transport_truck_using_compressed_natural_gas_share' WHERE `id` = 240;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_trains_efficiency' WHERE `id` = 241;"
    execute "UPDATE input_elements SET `key` = 'households_collective_chp_network_gas_share' WHERE `id` = 242;"
    execute "UPDATE input_elements SET `key` = 'households_lighting_incandescent_electricity_share' WHERE `id` = 245;"
    execute "UPDATE input_elements SET `key` = 'agriculture_burner_network_gas_share' WHERE `id` = 246;"
    execute "UPDATE input_elements SET `key` = 'investment_costs_earth_geothermal_electricity' WHERE `id` = 247;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_crude_oil_share' WHERE `id` = 248;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_ultra_supercritical_coal' WHERE `id` = 250;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_ultra_supercritical_ccs_coal' WHERE `id` = 251;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_combined_cycle_coal' WHERE `id` = 253;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_combined_cycle_ccs_coal' WHERE `id` = 254;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_ultra_supercritical_oxyfuel_ccs_lignite' WHERE `id` = 255;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_ultra_supercritical_network_gas' WHERE `id` = 256;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_combined_cycle_network_gas' WHERE `id` = 257;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_ultra_supercritical_crude_oil' WHERE `id` = 258;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_nuclear_gen3_uranium_oxide' WHERE `id` = 259;"
    execute "UPDATE input_elements SET `key` = 'electricity_green_gas_share' WHERE `id` = 260;"
    execute "UPDATE input_elements SET `key` = 'number_of_co_firing_coal' WHERE `id` = 261;"
    execute "UPDATE input_elements SET `key` = 'number_of_co_firing_gas' WHERE `id` = 262;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_wind_turbine_inland' WHERE `id` = 263;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_wind_turbine_coastal' WHERE `id` = 264;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_wind_turbine_offshore' WHERE `id` = 265;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_hydro_river' WHERE `id` = 266;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_hydro_mountain' WHERE `id` = 267;"
    execute "UPDATE input_elements SET `key` = 'number_of_blue_energy' WHERE `id` = 268;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_geothermal' WHERE `id` = 270;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_supercritical_waste_mix' WHERE `id` = 271;"
    execute "UPDATE input_elements SET `key` = 'number_of_buildings_collective_chp_wood_pellets_fixed' WHERE `id` = 272;"
    execute "UPDATE input_elements SET `key` = 'number_of_households_space_heater_micro_chp_network_gas_fixed' WHERE `id` = 274;"
    execute "UPDATE input_elements SET `key` = 'number_of_small_chp_fixed' WHERE `id` = 275;"
    execute "UPDATE input_elements SET `key` = 'number_of_large_chp' WHERE `id` = 276;"
    execute "UPDATE input_elements SET `key` = 'number_of_coal_chp_fixed' WHERE `id` = 277;"
    execute "UPDATE input_elements SET `key` = 'number_of_small_gas_chp_fixed' WHERE `id` = 279;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_chp_combined_cycle_network_gas_fixed' WHERE `id` = 280;"
    execute "UPDATE input_elements SET `key` = 'number_of_gas_fired_heater_fixed' WHERE `id` = 281;"
    execute "UPDATE input_elements SET `key` = 'number_of_oil_fired_heater_fixed' WHERE `id` = 282;"
    execute "UPDATE input_elements SET `key` = 'number_of_other_burner_coal' WHERE `id` = 283;"
    execute "UPDATE input_elements SET `key` = 'number_of_bio_oil_chp_fixed' WHERE `id` = 286;"
    execute "UPDATE input_elements SET `key` = 'number_of_electric_heat_pump_fixed' WHERE `id` = 289;"
    execute "UPDATE input_elements SET `key` = 'number_of_households_water_heater_solar_thermal_fixed' WHERE `id` = 290;"
    execute "UPDATE input_elements SET `key` = 'number_of_geothermal_fixed' WHERE `id` = 291;"
    execute "UPDATE input_elements SET `key` = 'transport_road_mixer_diesel_diesel_share' WHERE `id` = 292;"
    execute "UPDATE input_elements SET `key` = 'transport_road_mixer_diesel_biodiesel_share' WHERE `id` = 293;"
    execute "UPDATE input_elements SET `key` = 'transport_road_mixer_gasoline_gasoline_share' WHERE `id` = 294;"
    execute "UPDATE input_elements SET `key` = 'transport_road_mixer_gasoline_ethanol_share' WHERE `id` = 295;"
    execute "UPDATE input_elements SET `key` = 'transport_natural_gas_share' WHERE `id` = 296;"
    execute "UPDATE input_elements SET `key` = 'transport_bio_gas_share' WHERE `id` = 297;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_solar_pv_solar_radiation' WHERE `id` = 298;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_solar_csp_solar_radiation' WHERE `id` = 299;"
    execute "UPDATE input_elements SET `key` = 'number_of_households_solar_pv_solar_radiation_fixed' WHERE `id` = 313;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_supercritical_coal' WHERE `id` = 315;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_ultra_supercritical_lignite' WHERE `id` = 316;"
    execute "UPDATE input_elements SET `key` = 'households_heating_gas_fired_heat_pump_share' WHERE `id` = 317;"
    execute "UPDATE input_elements SET `key` = 'number_of_other_chp_engine_network_gas' WHERE `id` = 321;"
    execute "UPDATE input_elements SET `key` = 'number_of_industry_chp_combined_cycle_gas_power_fuelmix' WHERE `id` = 322;"
    execute "UPDATE input_elements SET `key` = 'industry_number_of_biomass_chp' WHERE `id` = 324;"
    execute "UPDATE input_elements SET `key` = 'number_of_agriculture_chp_engine_network_gas' WHERE `id` = 325;"
    execute "UPDATE input_elements SET `key` = 'industry_final_demand_steam_hot_water_share' WHERE `id` = 326;"
    execute "UPDATE input_elements SET `key` = 'agriculture_final_demand_steam_hot_water_share' WHERE `id` = 327;"
    execute "UPDATE input_elements SET `key` = 'transport_truck_using_compressed_natural_gas_efficiency' WHERE `id` = 328;"
    execute "UPDATE input_elements SET `key` = 'households_hot_water_gas_combi_heater_share' WHERE `id` = 333;"
    execute "UPDATE input_elements SET `key` = 'households_number_of_inhabitants' WHERE `id` = 335;"
    execute "UPDATE input_elements SET `key` = 'households_insulation_level_old_houses' WHERE `id` = 336;"
    execute "UPDATE input_elements SET `key` = 'households_insulation_level_new_houses' WHERE `id` = 337;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_heatpump_ground_water_electricity_share' WHERE `id` = 338;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_heatpump_add_on_electricity_share' WHERE `id` = 339;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_wood_pellets_share' WHERE `id` = 340;"
    execute "UPDATE input_elements SET `key` = 'households_heat_network_connection_steam_hot_water_share' WHERE `id` = 341;"
    execute "UPDATE input_elements SET `key` = 'households_collective_chp_wood_pellets_share' WHERE `id` = 343;"
    execute "UPDATE input_elements SET `key` = 'households_collective_geothermal_share' WHERE `id` = 344;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_network_gas_share' WHERE `id` = 346;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_resistive_electricity_share' WHERE `id` = 347;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_solar_thermal_share' WHERE `id` = 348;"
    execute "UPDATE input_elements SET `key` = 'households_cooling_heatpump_ground_water_electricity_share' WHERE `id` = 351;"
    execute "UPDATE input_elements SET `key` = 'households_cooling_gas_fired_heat_pump_share' WHERE `id` = 352;"
    execute "UPDATE input_elements SET `key` = 'households_cooling_airconditioning_electricity_share' WHERE `id` = 353;"
    execute "UPDATE input_elements SET `key` = 'households_cooker_network_gas_share' WHERE `id` = 354;"
    execute "UPDATE input_elements SET `key` = 'households_cooker_resistive_electricity_share' WHERE `id` = 355;"
    execute "UPDATE input_elements SET `key` = 'households_cooker_halogen_electricity_share' WHERE `id` = 356;"
    execute "UPDATE input_elements SET `key` = 'households_cooker_induction_electricity_share' WHERE `id` = 357;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_dishwasher_electricity_efficiency' WHERE `id` = 359;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_vacuum_cleaner_electricity_efficiency' WHERE `id` = 360;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_washing_machine_electricity_efficiency' WHERE `id` = 361;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_clothes_dryer_electricity_efficiency' WHERE `id` = 362;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_television_electricity_efficiency' WHERE `id` = 363;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_computer_media_electricity_efficiency' WHERE `id` = 364;"
    execute "UPDATE input_elements SET `key` = 'households_behavior_standby_killer_turn_off_appliances' WHERE `id` = 366;"
    execute "UPDATE input_elements SET `key` = 'households_behavior_turn_off_the_light' WHERE `id` = 368;"
    execute "UPDATE input_elements SET `key` = 'households_behavior_close_windows_turn_off_heating' WHERE `id` = 370;"
    execute "UPDATE input_elements SET `key` = 'households_behavior_low_temperature_washing' WHERE `id` = 371;"
    execute "UPDATE input_elements SET `key` = 'households_useful_demand_heat_per_person' WHERE `id` = 372;"
    execute "UPDATE input_elements SET `key` = 'households_useful_demand_hot_water_share' WHERE `id` = 373;"
    execute "UPDATE input_elements SET `key` = 'households_cooling_heat_pump_with_ts_share' WHERE `id` = 374;"
    execute "UPDATE input_elements SET `key` = 'households_heating_heat_pump_with_ts_share' WHERE `id` = 375;"
    execute "UPDATE input_elements SET `key` = 'number_of_buildings' WHERE `id` = 376;"
    execute "UPDATE input_elements SET `key` = 'buildings_useful_demand_cooling_electricity' WHERE `id` = 377;"
    execute "UPDATE input_elements SET `key` = 'buildings_useful_demand_for_space_heating' WHERE `id` = 378;"
    execute "UPDATE input_elements SET `key` = 'buildings_insulation_level_schools' WHERE `id` = 381;"
    execute "UPDATE input_elements SET `key` = 'buildings_insulation_level_offices' WHERE `id` = 382;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_network_gas_share' WHERE `id` = 383;"
    execute "UPDATE input_elements SET `key` = 'buildings_collective_chp_wood_pellets_share' WHERE `id` = 385;"
    execute "UPDATE input_elements SET `key` = 'buildings_collective_chp_network_gas_share' WHERE `id` = 386;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_electricity_share' WHERE `id` = 387;"
    execute "UPDATE input_elements SET `key` = 'buildings_heat_network_connection_steam_hot_water_share' WHERE `id` = 388;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_solar_thermal_share' WHERE `id` = 389;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_heatpump_air_water_network_gas_share' WHERE `id` = 390;"
    execute "UPDATE input_elements SET `key` = 'buildings_cooling_heatpump_air_water_network_gas_share' WHERE `id` = 391;"
    execute "UPDATE input_elements SET `key` = 'buildings_cooling_collective_heatpump_water_water_ts_electricity_share' WHERE `id` = 392;"
    execute "UPDATE input_elements SET `key` = 'buildings_cooling_airconditioning_share' WHERE `id` = 393;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_collective_heatpump_water_water_ts_electricity_share' WHERE `id` = 394;"
    execute "UPDATE input_elements SET `key` = 'buildings_ventilation_rate' WHERE `id` = 395;"
    execute "UPDATE input_elements SET `key` = 'buildings_recirculation' WHERE `id` = 396;"
    execute "UPDATE input_elements SET `key` = 'buildings_waste_heat_recovery' WHERE `id` = 397;"
    execute "UPDATE input_elements SET `key` = 'buildings_useful_demand_for_appliances' WHERE `id` = 398;"
    execute "UPDATE input_elements SET `key` = 'buildings_lighting_standard_fluorescent_electricity_share' WHERE `id` = 400;"
    execute "UPDATE input_elements SET `key` = 'buildings_lighting_efficient_fluorescent_electricity_share' WHERE `id` = 401;"
    execute "UPDATE input_elements SET `key` = 'buildings_lighting_led_electricity_share' WHERE `id` = 402;"
    execute "UPDATE input_elements SET `key` = 'buildings_lighting_savings_from_motion_detection_light' WHERE `id` = 403;"
    execute "UPDATE input_elements SET `key` = 'buildings_lighting_savings_from_daylight_control_light' WHERE `id` = 404;"
    execute "UPDATE input_elements SET `key` = 'buildings_solar_pv_solar_radiation_market_penetration' WHERE `id` = 405;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_wood_pellets_share' WHERE `id` = 406;"
    execute "UPDATE input_elements SET `key` = 'buildings_useful_demand_cooling' WHERE `id` = 408;"
    execute "UPDATE input_elements SET `key` = 'buildings_space_heater_crude_oil_share' WHERE `id` = 409;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_coal_share' WHERE `id` = 411;"
    execute "UPDATE input_elements SET `key` = 'households_appliances_other_electricity_efficiency' WHERE `id` = 412;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_nuclear_gen2_uranium_oxide' WHERE `id` = 413;"
    execute "UPDATE input_elements SET `key` = 'number_of_households_space_heater_wood_pellets_fixed' WHERE `id` = 414;"
    execute "UPDATE input_elements SET `key` = 'number_of_gas_fired_heat_pump_fixed' WHERE `id` = 415;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_power_combined_cycle_network_gas_ccs' WHERE `id` = 416;"
    execute "UPDATE input_elements SET `key` = 'households_hot_water_heat_pump_ground_share' WHERE `id` = 420;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_district_heating_steam_hot_water_share' WHERE `id` = 421;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_chp_ultra_supercritical_lignite' WHERE `id` = 422;"
    execute "UPDATE input_elements SET `key` = 'transport_planes_fossil_fuel_share' WHERE `id` = 423;"
    execute "UPDATE input_elements SET `key` = 'transport_planes_bio_based_fuel_share' WHERE `id` = 424;"
    execute "UPDATE input_elements SET `key` = 'transport_ships_fossil_fuel_share' WHERE `id` = 425;"
    execute "UPDATE input_elements SET `key` = 'transport_ships_bio_based_fuel_share' WHERE `id` = 426;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_trains_coal_share' WHERE `id` = 427;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_trains_diesel_share' WHERE `id` = 428;"
    execute "UPDATE input_elements SET `key` = 'transport_useful_demand_trains_electric_share' WHERE `id` = 429;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_heater_for_heat_network_coal' WHERE `id` = 430;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_heater_for_heat_network_wood_pellets' WHERE `id` = 431;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_heater_for_heat_network_network_gas' WHERE `id` = 432;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_heater_for_heat_network_waste_mix' WHERE `id` = 433;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_crude_oil_share' WHERE `id` = 435;"
    execute "UPDATE input_elements SET `key` = 'households_cooker_wood_pellets_share' WHERE `id` = 436;"
    execute "UPDATE input_elements SET `key` = 'number_of_energy_chp_ultra_supercritical_lignite_fixed' WHERE `id` = 437;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_fuel_cell_chp_network_gas_share' WHERE `id` = 439;"
    execute "UPDATE input_elements SET `key` = 'households_space_heater_network_gas_share' WHERE `id` = 441;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_coal_share' WHERE `id` = 443;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_wood_pellets_share' WHERE `id` = 444;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_micro_chp_network_gas_share' WHERE `id` = 445;"
    execute "UPDATE input_elements SET `key` = 'households_water_heater_combined_network_gas_share' WHERE `id` = 446;"
    execute "UPDATE input_elements SET `key` = 'policy_cost_energy_use' WHERE `id` = 447;"
    execute "UPDATE input_elements SET `key` = 'industry_demand' WHERE `id` = 448;"
    execute "UPDATE input_elements SET `key` = 'households_label_a' WHERE `id` = 450;"
    execute "UPDATE input_elements SET `key` = 'households_label_b' WHERE `id` = 451;"
    execute "UPDATE input_elements SET `key` = 'households_label_c' WHERE `id` = 452;"
    execute "UPDATE input_elements SET `key` = 'households_label_d' WHERE `id` = 453;"
    execute "UPDATE input_elements SET `key` = 'households_label_e' WHERE `id` = 454;"
    execute "UPDATE input_elements SET `key` = 'households_label_f' WHERE `id` = 455;"
    execute "UPDATE input_elements SET `key` = 'households_label_g' WHERE `id` = 456;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc0' WHERE `id` = 457;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc0_05' WHERE `id` = 458;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc05_10' WHERE `id` = 459;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc10_15' WHERE `id` = 460;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc15_20' WHERE `id` = 461;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc20_25' WHERE `id` = 462;"
    execute "UPDATE input_elements SET `key` = 'buildings_epc25' WHERE `id` = 463;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_a' WHERE `id` = 464;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_b' WHERE `id` = 466;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_c' WHERE `id` = 467;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_d' WHERE `id` = 468;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_e' WHERE `id` = 469;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_f' WHERE `id` = 470;"
    execute "UPDATE input_elements SET `key` = 'buildings_label_g' WHERE `id` = 471;"
    execute "UPDATE input_elements SET `key` = 'households_epc0' WHERE `id` = 472;"
    execute "UPDATE input_elements SET `key` = 'households_epc0_02' WHERE `id` = 473;"
    execute "UPDATE input_elements SET `key` = 'households_epc02_04' WHERE `id` = 474;"
    execute "UPDATE input_elements SET `key` = 'households_epc04_06' WHERE `id` = 475;"
    execute "UPDATE input_elements SET `key` = 'households_epc06_08' WHERE `id` = 476;"
    execute "UPDATE input_elements SET `key` = 'households_epc08_10' WHERE `id` = 477;"
    execute "UPDATE input_elements SET `key` = 'households_epc1' WHERE `id` = 478;"
    execute "UPDATE input_elements SET `key` = 'transport_public_transport' WHERE `id` = 480;"
    execute "UPDATE input_elements SET `key` = 'transport_bike' WHERE `id` = 481;"
    execute "UPDATE input_elements SET `key` = 'buildings_electricity_use' WHERE `id` = 482;"
    execute "UPDATE input_elements SET `key` = 'buildings_gas_use' WHERE `id` = 483;"
    execute "UPDATE input_elements SET `key` = 'transport_bio_fuels' WHERE `id` = 485;"
    execute "UPDATE input_elements SET `key` = 'transport_electric' WHERE `id` = 486;"
    execute "UPDATE input_elements SET `key` = 'transport_fossil_fuels' WHERE `id` = 487;"
    execute "UPDATE input_elements SET `key` = 'green_gas_total_share' WHERE `id` = 488;"
    execute "UPDATE input_elements SET `key` = 'natural_gas_total_share' WHERE `id` = 489;"

  end

  def self.down
  end
end
