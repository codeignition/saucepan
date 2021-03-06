class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Bagable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :ssh_key
  field :admin, type: Boolean, default: false
  field :name, type: String
  field :login_name, type: String
  field :user_id, type: Integer

  has_and_belongs_to_many :groups

  validates_presence_of :login_name, :user_id
  validates_uniqueness_of :login_name, :user_id

  def force_profile_update?
    newcomer? and ssh_key.nil?
  end

  def newcomer?
    sign_in_count <= 1
  end

  def to_key
    if key = super
      key = key.map(&:to_s)
    end
    key
  end

  def data
    {
      login_name => {
        'name'    => name,
        'user_id' => user_id,
        'ssh_key' => ssh_key,
        'groups'  => groups.collect(&:name)
      }
    }
  end
end
