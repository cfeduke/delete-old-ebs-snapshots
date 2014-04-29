require "test/unit"
require "date"
require_relative "../bin/delete-old-ebs-snapshots"

class Ec2SnapshotTest < Test::Unit::TestCase
  def subject
    Ec2Snapshot.parse("SNAPSHOT    snap-0bfd0417   vol-5c4e732b    completed   2013-12-17T21:55:25+0000    100%    296106742331    10  ext4 formatted 10GB logging drive
")
  end

  def test_snapshot_id
    assert subject.snapshot_id == "SNAPSHOT    snap-0bfd0417"
  end

  def test_volume_id
    assert subject.volume_id == "vol-5c4e732b"
  end

  def test_status
    assert subject.status == "completed"
  end

  def test_start_time
    assert subject.start_time == DateTime.new(2013, 12, 17, 21, 55, 25, '+0')
  end
end
