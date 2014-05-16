require 'base64'
require 'openssl'
require 'digest/sha1'


module S3Helper

  def s3_policy
    policy_document = {
        expiration: 1.day.from_now.iso8601,
        conditions: [
            #{bucket: 'mezerny'},
            {bucket: 'dev1-attachments'},
            ['starts-with', '$key', 'uploads/'],
            {acl: 'public-read'},
            {success_action_status: '200'},
        ]
    }
    Base64.encode64(policy_document.to_json).gsub("\n", '')
  end

  def s3_signature
    Base64.encode64(
        OpenSSL::HMAC.digest(
            OpenSSL::Digest::Digest.new('sha1'),
            #'MzRfEiSedou6CiD4ANf3WjMNLZ68wExqfZSUGb0V', s3_policy)
            'HyTa/XtWCRMRnrIpEpxH4nkBIK2I6cYqp+lmUeOg', s3_policy)
    ).gsub("\n", '')
  end

  def s3_access_key_id
   #'AKIAJODIQ43TOUBITXAQ'
    'AKIAIVWFQO3MUQ5GIPQQ'
  end
end