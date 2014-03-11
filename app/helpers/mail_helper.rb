require 'mandrill'
module MailHelper

  def send_email (options)
    begin
      mandrill = Mandrill::API.new 'cIRBbMhS1GJIgLhTCBD42g'
      message = {
          html: options[:html],
          text: options[:text],
          subject: options[:subject],
          from_email: options[:from_email],
          from_name: options[:from_name],
          to: [{email: options[:to_email],
                name: options[:to_name],
                type: 'to'}],
          headers: {'Reply-To' => options[:from_email]},
          important: true
      }
      async = false
      ip_pool = 'Main Pool'


      mandrill.messages.send message, async, ip_pool
    rescue Mandrill::Error => e
      # Mandrill errors are thrown as exceptions
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
      raise
    end
  end
end