require 'rails_helper'

describe TranslatorService do
  describe '.translate' do
    let(:dialect) { 'yoda' }
    let(:text) { 'I Yuru has lost a planet.' }
    let(:translated) { 'Lost a planet, I yuru has.' }
    let(:translation) { 'yoda' }

    subject{ described_class.translate(text, dialect) }

    context ' given a success return from API' do
      before do
        allow(described_class).to receive(:make_request) do
          {
            success: {
              total: 1
            },
            contents: {
              translated: translated,
              text: text,
              translation: translation
            }
          }.to_json
        end
      end

      it " returns the translated text" do
        expect(subject).to eq(translated)
      end
    end

    context ' given a failure return from API' do
      before do
        allow(described_class).to receive(:make_request) do
          {
            error: {
              code: 429,
              message: "Too Many Requests: Rate limit of 5 requests per hour exceeded. Please wait for 56 minutes and 54 seconds."
            }
          }.to_json
        end
      end

      it " returns the error mensagem text" do
        expect(subject).to eq("")
      end
    end
  end
end
