# PointBudget

Notre crédo : aider les consommateurs à savoir si ce qu’ils
              payent correspond bien au juste prix.

Venez donc faire un tout [ici](https://point-budget.herokuapp.com/)


document.getElementById('gas-simu').remove();
document.getElementById('gas-simu').style.display = "none";

document.getElementById("disa").setAttribute("disabled", true);

document.getElementById('disa').style.cursor = "not-allowed";


# Simulation with recuperation of data entered by user

<!--        GAS SIMULATION-->
      	<%case action %>
        <%when 'new_gas_simulation'%>
          <div class="form-group mb-5">
            <p>Coût annuel du gaz en €
            <%= number_field_tag "yearly_cost", nil, step: 1 , within: 1...10000, placeholder:0, class: 'd-flex justify-content-end' %>
            </p>
            <p>Connaissez vous votre consommation de gaz ?
            <%= radio_button_tag(:answer, "yes")%>
            <%= label_tag(:answer_yes, "Oui")%>
            <%= radio_button_tag(:answer, "no") %>
            <%= label_tag(:answer_no, "Non") %>
            </p>
            <div id="consumption" style="display:none;">
              <p>Consommation annuelle en kWh
              <%= number_field_tag "yearly_consumption", nil, step: 1, class: 'd-flex justify-content-end' %>
              </p>
            </div>
            <div id="estimation" style="display:none;">
              <h3>Estimation de votre consommation :</h3>
              <p>Superficie en m²
                <% if @full_simulation.only_one_ele_simulation && @full_simulation.ele_simulation.floor_space != nil %>
                  <%= number_field_tag "floor_space", value=@full_simulation.ele_simulation.floor_space, step: 1 , class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= number_field_tag "floor_space", nil, step: 1 , class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
              <p> Type de chauffage
                <% if @full_simulation.only_one_ele_simulation && @full_simulation.ele_simulation.heat_type != nil %>
                  <%= text_field_tag "heat_type", value=@full_simulation.ele_simulation.heat_type, class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= select_tag "heat_type", options_for_select(["", "Gaz", "Electricite", "Autre" ], "Non renseignée"), class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
              <p> Energie utilisée pour l'eau chaude et la cuisson
              <%= select_tag "water_cooking_type", options_for_select(["", "Gaz", "Electricite", "Autre"], "Non renseignée"), class: 'd-flex justify-content-end'%>
              </p>
              <p> Estimez la qualité de votre isolation
                <% if @full_simulation.only_one_ele_simulation && @full_simulation.ele_simulation.isolation_type != nil %>
                  <%= text_field_tag "isolation_type", value=@full_simulation.ele_simulation.isolation_type, class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= select_tag "isolation_type", options_for_select(["", "Peu performante", "Performante", "Très performante"], "Non renseignée"), class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
              <p>Nombres de personnes dans le logement
                <% if @full_simulation.only_one_ele_simulation && @full_simulation.ele_simulation.isolation_type != nil %>
                  <%= text_field_tag "nb_residents", value=@full_simulation.ele_simulation.residents_number, class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= number_field_tag "nb_residents", nil, step: 1 , class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
            </div>
          </div>
				
<!--        ELEC SIMULATION-->
        <%when 'new_ele_simulation'%>
          <div class="form-group mb-5">
            <p>Coût annuel de l'electricité en €
              <%= number_field_tag "yearly_cost", nil, step: 1 , within: 1...10000, placeholder:0, class: 'd-flex justify-content-end' %>
            </p>
            <p>Connaissez vous votre consommation d'électricité ?
            <%= radio_button_tag(:answer_elec, "yes")%>
            <%= label_tag(:answer_yes, "Oui")%>
            <%= radio_button_tag(:answer_elec, "no") %>
            <%= label_tag(:answer_no, "Non") %>
            </p>
            <div id="consumption-elec" style="display:none;">
              <p>Consommation annuelle en kWh
              <%= number_field_tag "yearly_consumption", nil, step: 1, class: 'd-flex justify-content-end' %>
              </p>
            </div>
            <div id="estimation-elec" style="display:none;">
              <h3>Estimation de votre consommation:</h3>
              <p>Superficie en m²
                <% if @full_simulation.only_one_gas_simulation && @full_simulation.gas_simulation.floor_space != nil %>
                  <%= number_field_tag "floor_space", value=@full_simulation.gas_simulation.floor_space, step: 1 , class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= number_field_tag "floor_space", nil, step: 1 , class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
              <p> Type de chauffage
                <% if @full_simulation.only_one_gas_simulation && @full_simulation.gas_simulation.heat_type != nil %>
                  <%= text_field_tag "heat_type", value=@full_simulation.gas_simulation.heat_type, class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= select_tag "heat_type", options_for_select(["", "Gaz", "Electricite", "Autre" ], "Non renseignée"), class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
              <p> Energie utilisée pour l'eau chaude
              <%= select_tag "water_type", options_for_select(["", "Gaz", "Electricite", "Autre"], "Non renseignée"), class: 'd-flex justify-content-end'%>
              </p>
              <p> Energie utilisée pour la cuisson
              <%= select_tag "cooking_type", options_for_select(["", "Gaz", "Electricite", "Autre"], "Non renseignée"), class: 'd-flex justify-content-end'%>
              </p>
              <p> Estimez la qualité de votre isolation
                <% if @full_simulation.only_one_gas_simulation && @full_simulation.gas_simulation.isolation_type != nil %>
                  <%= text_field_tag "isolation_type", value=@full_simulation.gas_simulation.isolation_type, class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= select_tag "isolation_type", options_for_select(["", "Peu performante", "Performante", "Très performante"], "Non renseignée"), class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
              <p>Nombres de personnes dans le logement
                <% if @full_simulation.only_one_gas_simulation && @full_simulation.gas_simulation.isolation_type != nil %>
                  <%= text_field_tag "nb_residents", value=@full_simulation.gas_simulation.residents_number, class: 'd-flex justify-content-end'%>
                <% else %>
                  <%= number_field_tag "nb_residents", nil, step: 1 , class: 'd-flex justify-content-end'%>
                <% end %>
              </p>
            </div>
            <p>Quelle est la puissance de votre compteur en kVa?
              <%= number_field_tag "kVA_power", nil, in: 6..12 , step: 3 , placeholder:0, class: 'd-flex justify-content-end' %>
            </p>
          </div>