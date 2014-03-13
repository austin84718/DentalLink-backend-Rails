require 'mandrill'
module InviteHelper
  include MailHelper

  def invite_practice(practice_invitation_params)
    practice_invite = PracticeInvitation.new(practice_invitation_params)
    send_result = send_mail_notification(practice_invite)
    practice = Practice.new({name: practice_invite.practice_name, status: :invite})
    practice.practice_invitations << practice_invite
    practice.save
    practice
  end

  def send_mail_notification (practice_invite)
    send_email({
                   template_name: "practice-invitation",
                   template_content: {},
                   global_merge_vars:{},
                   merge_vars: [{
                       rcpt: practice_invite.contact_email,
                       vars: [
                           {name: 'FIRST_NAME', content: practice_invite.contact_first_name},
                           {name: 'LAST_NAME', content: practice_invite.contact_last_name},
                       ]
                   }
                   ],
                   recipients: [ {email: practice_invite.contact_email, name: "#{practice_invite.contact_first_name} #{practice_invite.contact_last_name}", type: 'to'} ]
               })
  end
end