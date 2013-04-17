require 'spec_helper'

describe Dcentralized do
  it 'should remove spaces from zipcode' do
    Dcentralized.format_zipcode("2564 AZ").should eq "2564AZ"
  end

  it 'should upcase the zipcode' do
    Dcentralized.format_zipcode("2564az").should eq "2564AZ"
  end

  it 'should raise an exception' do
    expect { Dcentralized.format_zipcode(nil) }.to raise_error
    expect { Dcentralized.format_zipcode("") }.to raise_error
    expect { Dcentralized.format_zipcode("111") }.to raise_error
    expect { Dcentralized.format_zipcode("1111A") }.to raise_error
    expect { Dcentralized.format_zipcode("11111A") }.to raise_error
    expect { Dcentralized.format_zipcode("AAAA") }.to raise_error
    expect { Dcentralized.format_zipcode("11AA") }.to raise_error
  end

  it 'should return high detailed result' do
    VCR.use_cassette('auto_complete_high') do
      xml_response_mock = '{"nl_sixpp":["2564AZ"],"street":["Laan van Meerdervoort"],"city":["\'s-Gravenhage"],"municipality":["\'s-Gravenhage"],"province":["Zuid-Holland"],"streetnumbers":["1096-1126"],"lat":["52.06751"],"lng":["4.24733"],"areacode":["070"]}'
      Dcentralized.auto_complete("2564AZ").should eq xml_response_mock
      Dcentralized.auto_complete("2564AZ").should include('"street":[')
    end
  end

  it 'should return low detailed result' do
    VCR.use_cassette('auto_complete_low') do
      xml_response_mock = '{"nl_fourpp":["2564"],"city":["\'s-Gravenhage"],"municipality":["\'s-Gravenhage"],"province":["Zuid-Holland"],"areacode":["070"],"lat":["52.068"],"lng":["4.25724"]}'
      Dcentralized.auto_complete("2564").should eq xml_response_mock
      Dcentralized.auto_complete("2564").should_not include('"street":[')
    end
  end

  it 'should return correct version string' do
    Dcentralized.version_string.should eq "Dcentralized version #{Dcentralized::VERSION}"
  end
end