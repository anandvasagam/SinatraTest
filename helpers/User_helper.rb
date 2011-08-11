#Helper file for User Model

#Renders the Success/Failure XML Response
def render_xml_output(status)
  builder do |xml|
    xml.instruct!
    xml.response do
      xml.status status
    end
  end
end

#Renders the Users XML Response
def render_users_xml(userlist)
  builder do |xml|
     xml.instruct!
     xml.users do
        userlist.each do |user|
          xml.user :id => user.id do
            xml.username user.username
            xml.displayname user.displayname
            xml.headendID user.headendID
            @sections = get_sections_for_user(user.id)
            @sections.each do |section|
              xml.section :id => section.id do
                xml.userId section.userId
                xml.title section.title
                xml.shows section.shows
                xml.actors section.actors
              end
            end
          end
        end
     end
   end
end

#Fetches all the Users 
def display_all
  @user = User.find(:all)
  render_users_xml(@user)
end

#Create a new User
def create_user
  @newuser = User.new(:username => params[:name], 
  :displayname => params[:displayname],
  :headendID => params[:headendID])
  if @newuser.save
   render_xml_output("Success")
  else  
    render_xml_output("Failure")
  end
end

#Modifies an existing user
def modify_user
  begin
@user = User.find(params[:id])
    if(@user)
     if(params[:name]) 
       @user.username = params[:name]
     end
     if(params[:displayname])
       @user.displayname = params[:displayname]
     end
     if(params[:headendID])
     @user.headendID = params[:headendID]
     end
     if @user.save
        render_xml_output("Success")
     else
       render_xml_output("Failure")
     end
  end
  rescue ActiveRecord::RecordNotFound
    render_xml_output("No record found")
  end
end

#Deletes an existing user and corresponding sections for the user
def delete_user
  begin
  @user = User.find(params[:id])
  if(@user)
    #@sections = get_sections_for_user(@user.id);
    if @user.destroy
      #if(@sections)
        #@sections.each do |section|
          #section.destroy
        #end
      #end
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