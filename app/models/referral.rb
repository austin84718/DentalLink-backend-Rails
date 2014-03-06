class Referral < ActiveRecord::Base
  include MailHelper
  belongs_to :orig_practice, class_name: 'Practice'
  belongs_to :dest_practice, class_name: 'Practice'
  belongs_to :patient
  has_many :attachment

  after_create :send_email_to_doctor

  validates :orig_practice_id, :dest_practice_id, :patient_id, presence: true

  def send_email_to_doctor
    if self.dest_practice.users.any?
      send_email({
                     html: "<h2>You have received new referral!</h2><p>Click <a href='http://referral-frontend.s3-website-us-east-1.amazonaws.com/pages/#/sign_in'>here</a> to see the referral that doctor #{self.orig_practice.users.first.first_name} #{self.orig_practice.users.first.last_name} just sent you.</p>",
                     text: "You have received new referral! Visit this URL to see the referral that doctor #{self.orig_practice.users.first.first_name} #{self.orig_practice.users.first.last_name} just sent you: http://referral-frontend.s3-website-us-east-1.amazonaws.com/pages/#/sign_in",
                     subject: 'You have received a referral!',
                     from_email: 'dental.links@example.com',
                     from_name: 'Dental Links Team',
                     to_email: self.dest_practice.users.first.email,
                     to_name: "#{self.dest_practice.users.first.first_name} #{self.dest_practice.users.first.last_name}"

                 })
    end
  end
end
