# -*- coding: utf-8 -*-
require "spec_helper"

module Guideline
  describe KusakabeChecker do
    describe "#check" do
      let(:checker) do
        described_class.new
      end

      let(:path) do
        mock(:each_line => script.each_line)
      end

      context "when there is hankakukana" do
        let(:script) do
          <<-EOF
            def foo
              p 'mojibake shitemasuyo ｱｲｳｴｵ'
            end
          EOF
        end

        it "detects error" do
          checker.check(path)
          checker.should have_error
        end
      end

      context "when there is no hankakukana" do
        let(:script) do
          <<-EOF
            def foo
              p '　ヘ＿ヘ'
              p 'ミ・・　ミ　　'
              p '（　　　）～'
            end
          EOF
        end

        it "does not detect error" do
          checker.check(path)
          checker.should_not have_error
        end
      end
    end
  end
end
