require 'csv'
namespace :gallery do

  def split_to_array(content)
    unless content.nil?
     content.split("|") 
    end
  end

  desc "import gallery images and metadata"
  task:import => :environment do
    begin
      file = open("#{Rails.root}/tmp/hor_images.csv")
    rescue Errno::ENOENT => e
      puts "\n*** Import CSV not found.\n\tSee README for details.\n"
      raise e
    end
    CSV.foreach(file, headers: true, encoding: 'windows-1251:utf-8') do |row|
      begin
        gallery_image = GalleryImage.new
        gallery_image.title = row['title']
        gallery_image.creator = row['creator']
        gallery_image.date = row['date']
        gallery_image.description = row['description']
        gallery_image.source_text = row['source_text']
        gallery_image.source_link = row['source_link']
        gallery_image.format = split_to_array(row['format'])
        gallery_image.subject = split_to_array(row['subject'])
        gallery_image.image = open("#{Rails.root}/tmp/hor_images/#{row['file_name']}")
        gallery_image.save
        puts '::success::'
      rescue Errno::ENOENT => e
        puts "\n*** Broken image link in csv.\n"
        puts "\t#{e}\n\n"
        next
      end
    end
  end
end

