require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read('./fixtures/student-site/index.html')
    students = Nokogiri::HTML(html)
    #The keys of the individual student hashes should be :name, :location     :profile_url 
    
    people_hashed = []

    #students: students.css("div.roster-cards-container")


    students.css("div.student-card").each do |student|
      people_hashed << {
        :name => student.css("div.card-text-container h4.student-name").text,
        :location => student.css("div.card-text-container p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
    end
    people_hashed
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profiles = {}
    #What we want to access
      #twitter, linkedin, github, blog, profile, and bio
        #:twitter => doc.css("div.social-icon-container a:first-child").attribute("href").value
        #:linkedin => doc.css("div.social-icon-containter a:nth-child(2)").attribute("href").value,
        #:github => doc.css("div.social-icon-container a:nth-child(3)").attribute("href").value,
        #:blog => doc.css("div.social-icon-container a:last-child").attribute("href").value,
        #:profile_quote => doc.css("div.vitals-text-container div.profile-quote").text,
        #:bio => doc.css("div.details-container div.descroption-holder p").text

    doc.css("div.social-icon-container a").each do |socials|
      social_link = socials['href']
      if social_link.include?("twitter")
        profiles[:twitter] = social_link
      elsif social_link.include?("linkedin")
        profiles[:linkedin] = social_link
      elsif social_link.include?("github")
        profiles[:github] = social_link
      elsif
        profiles[:blog] = social_link
      end
    end

    profiles[:profile_quote] = doc.css("div.vitals-text-container div.profile-quote").text
    profiles[:bio] = doc.css("div.details-container div.description-holder p").text
    profiles
  end
  
end

