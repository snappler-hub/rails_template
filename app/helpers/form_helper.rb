module FormHelper

  #---------------------------------------------------------------
  def order_url(field_name, filter_params={})
    filter_params = (filter_params.to_h || {}).dup
    filter_params[:order] = field_name
    filter_params[:direction] = (filter_params[:direction] == 'asc') ? 'desc' : 'asc'
    return {filter: filter_params}
  end

  #---------------------------------------------------------------
  def field_data(id, fields)
    {id: id, fields: fields.gsub("\n", "").gsub('"', "'")}
  end

end