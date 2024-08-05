class CreateSystemRequirements < ActiveRecord::Migration[7.0]
  def change
    create_table :system_requirements do |t|
      t.references :game, null: false, foreign_key: true
      t.string :min_os
      t.string :min_processor
      t.string :min_memory
      t.string :min_graphics
      t.string :min_directx
      t.string :min_storage
      t.string :min_sound_card
      t.string :rec_os
      t.string :rec_processor
      t.string :rec_memory
      t.string :rec_graphics
      t.string :rec_directx
      t.string :rec_storage
      t.string :rec_sound_card

      t.timestamps
    end
  end
end
