require 'spec_helper'

describe PipedRuby do
  it 'has a version number' do
    expect(PipedRuby::VERSION).not_to be nil
  end

  describe '#>>' do
    let(:operation) do
      -> { 1 }.>> { |e| e + 1 }.>> { |e| e * 2 }
    end

    it { expect(operation.to_pipe).to eq(4) }
    it { expect(operation.piped).to eq(2) }
    it { expect(operation.unwrap).to eq(4) }

    it 'returns a reference from self (Proc)' do
      expect(operation).to be_kind_of(Proc)
    end

    context 'when it is the first pipe' do
      it 'calls the current block' do
        first = -> { 'Foo' }
        expect(first.unwrap).to eq('Foo')
        expect(first.>> { |e| "#{e}bar" }.piped).to eq('Foo')
      end
    end
  end

  describe '#unwrap' do
    context 'when no pipe was called' do
      it 'calls the current block' do
        expect(-> { 'Foobar' }.unwrap).to eq('Foobar')
      end
    end

    context 'when piped value is nil' do
      it 'calls the current block' do
        expect(
          -> { 'Lorem' }
            .>> { |e| "#{e} ipsum" }
            .>> { |e| "#{e} sit" }
            .>> { |e| "#{e} amet" }
            .>> { |e| puts e } # Prints "Lorem ipsum sit amet" and pipes nil
            .>> { |e| 1 }.unwrap
        ).to eq(1)
      end
    end

    context 'when piped' do
      it 'returns the piped value from the last block' do
        expect(-> { 'Foobar' }.>> { 'Bar' }.unwrap).to eq('Bar')
        expect(-> { 'Foo' }.>> { |e| "#{e}bar" }.unwrap).to eq('Foobar')
        expect(-> { 1 }.>> { |e| e * 4 }
                       .>> { |e| e == 4 ? e / 2 : e }.unwrap).to eq(2)
      end
    end
  end
end
