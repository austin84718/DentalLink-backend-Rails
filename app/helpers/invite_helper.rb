require 'mandrill'
module InviteHelper


  def invite_practice(practice_invitation_params)
    practice_invite = PracticeInvitation.new(practice_invitation_params)
    send_result = send_mail_notification(practice_invite)
    practice = Practice.new({name: practice_invite.practice_name, status: :invite})
    practice.practice_invitations << practice_invite
    practice.save
    practice
  end

  def send_mail_notification (practice_invite)
    begin
      mandrill = Mandrill::API.new 'cIRBbMhS1GJIgLhTCBD42g'
      message = {template_name: 'practice-invitation',
                 template_content: [
                     {
                         name: 'FIRST_NAME',
                         content: practice_invite.contact_first_name
                     },
                     {
                         name: 'LAST_NAME',
                         content: practice_invite.contact_last_name
                     }
                 ],
                 to: [{email: practice_invite.contact_email,
                       name: "#{practice_invite.contact_first_name} #{practice_invite.contact_last_name}",
                       type: 'to'}],
                 important: true
      }
      async = false
      ip_pool = 'Main Pool'


      mandrill.messages.send message, async, ip_pool
        # [{"email"=>"recipient.email@example.com",
        #     "status"=>"sent",
        #     "reject_reason"=>"hard-bounce",
        #     "_id"=>"abc123abc123abc123abc123abc123"}]

    rescue Mandrill::Error => e
      # Mandrill errors are thrown as exceptions
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
      # A mandrill error occurred: Mandrill::UnknownSubaccountError - No subaccount exists with the id 'customer-123'
      raise
    end
  end
end