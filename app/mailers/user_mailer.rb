class UserMailer < ActionMailer::Base
  def send_placements_notification(user)
    @user = user
    mail :from => 'sangyoon park<secretsvd@berkeley.edu>',
         :to => user.email,
         :subject => "[BSMI] Please check your placements"
  end
end
