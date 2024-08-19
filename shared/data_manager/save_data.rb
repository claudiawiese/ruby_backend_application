# frozen_string_literal: true

# This class is in charge of savin data to output.json
class SaveData
    def self.save_data(file_path, output)
      File.open(file_path, 'w') do |f|
        f.write(JSON.pretty_generate(output))
      end
      puts 'Data has been saved to output.json'
    end
  end