# frozen_string_literal: true

require 'spec_helper'

describe Dcentralized do
  it 'removes spaces from zipcode' do
    expect(Dcentralized.format_zipcode('2564 AZ')).to eq '2564AZ'
  end

  it 'upcases the zipcode' do
    expect(Dcentralized.format_zipcode('2564az')).to eq '2564AZ'
  end

  it 'raises an exception' do
    type = Dcentralized::InvalidPostcodeException
    expect { Dcentralized.format_zipcode(nil) }.to raise_error(type)
    expect { Dcentralized.format_zipcode('') }.to raise_error(type)
    expect { Dcentralized.format_zipcode('111') }.to raise_error(type)
    expect { Dcentralized.format_zipcode('1111A') }.to raise_error(type)
    expect { Dcentralized.format_zipcode('11111A') }.to raise_error(type)
    expect { Dcentralized.format_zipcode('AAAA') }.to raise_error(type)
    expect { Dcentralized.format_zipcode('11AA') }.to raise_error(type)
  end

  it 'returns a high detailed result' do
    VCR.use_cassette('auto_complete_high') do
      xml_response_mock = {
        nl_sixpp: '2564AZ',
        street: 'Laan van Meerdervoort',
        city: "'s-Gravenhage",
        municipality: "'s-Gravenhage",
        province: 'Zuid-Holland',
        streetnumbers: '1096-1126',
        lat: 52.067554,
        lng: 4.247434,
        areacode: '070'
      }
      expect(Dcentralized.auto_complete('2564AZ')).to eq OpenStruct.new(xml_response_mock)
      expect(Dcentralized.auto_complete('2564AZ').street).to eq 'Laan van Meerdervoort'
    end
  end

  it 'returns a low detailed result' do
    VCR.use_cassette('auto_complete_low') do
      xml_response_mock = {
        nl_fourpp: 2564,
        city: "'s-Gravenhage",
        municipality: "'s-Gravenhage",
        province: 'Zuid-Holland',
        areacode: '070',
        lat: 52.06703,
        lng: 4.30274
      }
      expect(Dcentralized.auto_complete('2564')).to eq OpenStruct.new(xml_response_mock)
      expect(Dcentralized.auto_complete('2564').street).to eq nil
    end
  end

  it 'returns the correct version string' do
    expect(Dcentralized.version_string).to eq "Dcentralized version #{Dcentralized::VERSION}"
  end
end
