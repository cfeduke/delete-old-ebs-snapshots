require 'test/unit'
require_relative '../bin/delete-old-ebs-snapshots'

class Ec2SnapshotsParserTest < Test::Unit::TestCase
  def subject(fixture, &block)
    s = Ec2SnapshotsParser.new(IO.readlines("./test/fixtures/#{fixture}.txt"))
    block.call(s)
  end

  def test_reads_all_rows_for_old
    expected = 54
    subject("sample-data-old") { |s| assert(s.snapshots.length == expected, "Expected #{expected} snapshots, actually #{s.snapshots.length} snapshots") }
  end

  def test_reads_all_rows_for_new
    expected = 4205
    subject("sample-data-new") { |s| assert(s.snapshots.length == expected, "Expected #{expected} snapshots, actually #{s.snapshots.length} snapshots") }
  end

end
