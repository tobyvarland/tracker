class RenameEntryDateColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :entries,
                  :entry_on,
                  :entry_date
  end
end
