module LeadsHelper
  def leads_sort_link(label, key)
    next_direction = (@sort == key && @direction == "asc") ? "desc" : "asc"
    indicator = if @sort == key
      @direction == "asc" ? "▲" : "▼"
    else
      "↕"
    end
    query = request.query_parameters.merge(sort: key, direction: next_direction)
    active = @sort == key ? "is-active" : nil

    link_to leads_path(query), class: ["table-sort-link", active] do
      safe_join([content_tag(:span, label), content_tag(:span, indicator, class: "sort-indicator")], " ")
    end
  end
end
