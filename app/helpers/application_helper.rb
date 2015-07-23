module ApplicationHelper
  def page_title
    title = "Vintage Vintage"
    if @page_title 
      title = @page_title+" - "+title
    end
    title
  end
end
