#Helper file for the Sections

#Renders the Success/Failure XML Response
def render_xml_output(status)
  builder do |xml|
    xml.instruct!
    xml.response do
      xml.status status
    end
  end
end

#Renders the XML output of all sections
def render_sections_xml(sectionslist)
  builder do |xml|
     xml.instruct!
     xml.sections do
        sectionslist.each do |section|
          xml.section do
            xml.userId section.userId
            xml.title section.title
            xml.shows section.shows
            xml.actors section.actors
          end
        end
     end
   end
end

#Creates a new Section for a user
def create_section 
  begin
    #@user = User.find(params[:id])
    #if(@user)
      @newsection = Section.new(
      :userId => params[:id], 
      :title => params[:title],
      :shows => params[:shows],
      :actors => params[:actors])
      if @newsection.save
        render_xml_output("Success")
      else  
        render_xml_output("Section could not be added")
      end
    #else
    #render_xml_output("No user id Match")
    #end
  rescue ActiveRecord::RecordNotFound 
    render_xml_output("No User Id matched")
  end
end

#Displays all the exisiting sessions
def view_all_sections 
  @section = Section.find(:all)
  render_sections_xml(@section)
end

#Displays sections for a particular user
def view_section_for_user 
  begin
  @user = User.find(params[:id])
    if(@user)
      builder do |xml|
        xml.instruct!
        xml.sections do
          @sections = get_sections_for_user(@user.id)
            @sections.each do |section|
              xml.section do
                xml.userId section.userId
                xml.title section.title
                xml.shows section.shows
                xml.actors section.actors
              end
            end
        end
      end
    else
      render_xml_output("No user id Match")
    end
  rescue ActiveRecord::RecordNotFound 
    render_xml_output("No User Id matched")
  end
end

#Modify a section
def modify_section 
  begin
    @section = Section.find(params[:id])
    if(@section)
     if(params[:title]) 
       @section.title = params[:title]
     end
     if(params[:shows])
       @section.shows = params[:shows]
     end
     if(params[:actors])
     @section.actors = params[:actors]
     end
     if @section.save
        render_xml_output("Success")
     else
       render_xml_output("Failure")
     end
  end
  rescue ActiveRecord::RecordNotFound
    render_xml_output("No record found")
  end
end

#Delete a section
def delete_section
  begin
  @section = Section.find(params[:id])
  if(@section)
    if @section.destroy
      render_xml_output("Success")
    else
      render_xml_output("Failure")
    end
  else
    render_xml_output("user doesn\'t exist")
  end
  rescue ActiveRecord::RecordNotFound
    render_xml_output("No record found")
  end
end

#Fetch sections for a paritcular user
def get_sections_for_user(userId)
  @sections = Section.find(:all,:conditions => ["userId = ?", userId])
  return @sections
end