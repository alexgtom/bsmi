# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    when /^the mentor_teacher new schedule page$/      
      '/mentor_teacher/schedule/new'
    when /^the home page/
      '/'
    when %r{/mentor_teacher/schedule/new}
      '/mentor_teacher/schedule/new'
    when /^the user\s?page$/
      '/user'
    when /^the users\s?page$/
      '/users'
    when /^the user session\s?page$/
      '/user_sessions'
    when /^the edit\s?page$/
      '/users/2/edit'
    when /^CalCourse new page$/
      '/cal_courses/new'
    when /^CalCourse edit page$/
      '/cal_courses/2/edit'
    when /^CalCourse show page$/
      '/cal_courses/2/'
    when /^CalCourse index page$/
      '/cal_courses/'
    when %r{/.*} #Literal path
      page_name

      # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
