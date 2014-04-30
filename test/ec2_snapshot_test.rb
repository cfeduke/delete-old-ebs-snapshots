require "test/unit"
require "date"
require_relative "../bin/delete-old-ebs-snapshots"

class Ec2SnapshotTest < Test::Unit::TestCase
  def subject
    Ec2Snapshot.parse("SNAPSHOT\tsnap-0bfd0417\tvol-5c4e732b\tcompleted\t2013-12-17T21:55:25+0000\t100%\t296106742331\t10\text4 formatted 10GB logging drive
")
  end

  def test_snapshot_id
    assert subject.snapshot_id == "snap-0bfd0417"
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

  def test_parse_ignores_lines_which_do_not_begin_with_SNAPSHOT
    s = Ec2Snapshot.parse("TAG snapshot    snap-0bfd0417   Name    var-log-trafficland-template")
    assert s.nil?
  end

end
