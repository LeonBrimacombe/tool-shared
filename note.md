   <div class="grid backing">
      <% if @tools.empty? %>
        <p>No tools available</p>
      <% else %>
        <% @tools.each do |tool| %>
          <%= link_to tool_path(tool) do%>
            <div class="card-tool">
              <% if tool.images.attached? %>
                <%= cl_image_tag tool.images.first.key, style:"width:200px;", alt: "#{tool.name}"%>
              <% end %>
              <div class="card-tool-info">
                <div>
                  <h2><%= tool.name %></h2>
                  <p><%= tool.description %></p>
                  <i class="fa-solid fa-location-pin location"></i> <%= tool.address %>
                </div>
                <div class="card-tool-pricing">
                  <h3>£<%= tool.price %></h3>
                </div>
              </div>
            </div>
          <% end %>
        <% end %>
      <% end %>
    </div>
