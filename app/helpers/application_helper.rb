module ApplicationHelper

  #############################################
  # Returns the page title on a per-page basis.
  ##############################################
  def full_title(page_title)
    base_title = "Storyland Daycare"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  
  #############################################
  # Takes a form and the name of an association
  # between models, i.e. if can do children.parents,
  # children has # "parents" as a relation. Creates
  # a new object of the passed association type 
  # (i.e. Parent) and creates a nested form builder
  # that will build that object through its
  # association (i.e. equivalent to calling
  # child.build.parent)
  ##############################################
  def link_to_add_fields(f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
  end  
end