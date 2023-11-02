class Upload < ApplicationRecord
  belongs_to :game
  has_one_attached :game_files, dependent: :destroy
  belongs_to :user
  belongs_to :translater
  belongs_to :program
  belongs_to :platform
  has_many :downloads, dependent: :destroy
  has_many :uploadtranslaters, dependent: :destroy
  validates :game_files, presence: true
  validates :version, presence: true
  has_many_attached :pictures, dependent: :destroy
  def self.default_timezone
    :utc
  end
  end
