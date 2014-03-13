require 'mandrill'
module MailHelper

  def send_email (options)
    begin
      mandrill = Mandrill::API.new 'cIRBbMhS1GJIgLhTCBD42g'
      message = {
          to: options[:recipients],
          global_merge_vars: options[:global_merge_vars],
          merge_vars: options[:merge_vars],
          important: true
      }
      mandrill.messages.send_template options[:template_name], options[:template_content], message
    rescue Mandrill::Error => e
      # Mandrill errors are thrown as exceptions
      puts "A mandrill error occurred: #{e.class} - #{e.message}"
      raise
    end
  end
end