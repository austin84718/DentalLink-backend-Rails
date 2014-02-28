require 'mandrill'
module InviteHelper


  def invite_practice(practice_invitation_params)
    practice_invite = PracticeInvitation.new(practice_invitation_params)
    send_result  = send_mail_notification(practice_invite)
    practice = Practice.new({name: practice_invite.practice_name, status: :invite})
    practice.practice_invitations << practice_invite
    practice.save
    practice
  end

  def send_mail_notification (practice_invite)
    begin
      mandrill = Mandrill::API.new 'cIRBbMhS1GJIgLhTCBD42g'
      message = {html: "<div><h2>Your practice has been invited to the Dental Link application!</h2>
                        <p>Dear #{practice_invite.contact_first_name} #{practice_invite.contact_last_name}!</p>
                        <p>You have received a referral to  your practice. To see details of the referral please sign up to the system and provide us with details about your practice.</p>
                        <p>Please follow this link to start working with <a href='example.com'>Dental Links</a>
                        <p>We will be very glad to see you in our application.</p>
                        <p>Thank you!</p>
                        <p>Sincerely, your Dental Links Team</p></div>",
                 text: 'Your practice has been invited to the Dental Link application! You have received a referral to  your practice. To see details of the referral please sign up to the system and provide us with details about your practice. We will be very glad to see you in our application. Sincerely, your Dental Links Team',
                 subject: 'Practice invitation',
                 from_email: 'dental.links@example.com',
                 from_name: 'Dental Links',
                 to: [{email: practice_invite.contact_email,
                       name: "#{practice_invite.contact_first_name} #{practice_invite.contact_last_name}",
                       type: 'to'}],
                 headers: {'Reply-To' => 'dental.links@example.com'},
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