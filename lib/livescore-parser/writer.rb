require 'builder'
require_relative 'hash_helper'

module LivescoreParser
  class Writer

    def initialize(scores)
      @scores = scores
    end

    def run
      @scores.each do |page|
        File.open(page[:path], "w+") do |file|
          file.write(build_xml(page[:data]))
        end
      end
    end

    private

    # Builds XML data from schedule Hash
    def build_xml(data)
      xml_builder = Builder::XmlMarkup.new( :indent => 2 )
      xml_builder.instruct! :xml, :encoding => "UTF-8"
      xml_builder.xml do |xml|
        data.each do |score|
          xml.node do |node|
            node.wiersz score[:wiersz]
            node.czas   score[:czas]
            node.gracz1 score[:gracz1]
            node.wynik1 score[:wynik1]
            node.gracz2 score[:gracz2]
            node.wynik2 score[:wynik2]
            node.kraj   score[:kraj]
            node.liga   score[:liga]
            node.data   score[:data]
          end
        end
      end
    end
  end
end
