# encoding: utf-8
describe TimeBoots::Lace do
  let(:from){t('2014-03-10')}
  let(:to){t('2014-11-10')}

  let(:lace){described_class.new(:month, from, to)}
  subject{lace}
  
  describe 'creation' do
    its(:from){should == from}
    its(:to){should == to}
  end

  describe '#expand!' do
    before{subject.expand!}

    its(:from){should == TimeBoots::Boot.month.floor(from)}
    its(:to){should == TimeBoots::Boot.month.ceil(to)}
  end

  describe '#expand' do
    let(:expanded){lace.expand}

    describe 'expanded' do
      subject{expanded}

      its(:from){should == TimeBoots::Boot.month.floor(from)}
      its(:to){should == TimeBoots::Boot.month.ceil(to)}
    end

    describe 'original' do
      subject{lace}

      its(:from){should == from}
      its(:to){should == to}
    end
  end

  describe '#pull' do
    let(:fixture){load_fixture(:lace_pull)}
    let(:from){t(fixture[:from])}
    let(:to){t(fixture[:to])}

    let(:lace){described_class.new(fixture[:step], from, to)}

    let(:expected){fixture[:sequence].map(&method(:t))}

    subject{lace.pull}

    it{should == expected}
    
    context 'when pulling beginnings' do
      let(:expected){fixture[:sequence_beg].map(&method(:t))}

      subject{lace.pull(beginnings: true)}

      it{should == expected}
    end
  end

  describe '#pull_pairs' do
    context 'when pulling beginnings' do
    end
  end
end