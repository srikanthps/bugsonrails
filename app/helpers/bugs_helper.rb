module BugsHelper

  def bug_feeling (bug)
     
    feeling = "two_persons" if bug.status == "Code review, please!"
    feeling = "bag" if bug.status == "Ready for build"
    feeling = "person" if bug.status == "Working on it"
    feeling = "question" if bug.status == "Pending clarification"
    feeling = "locked" if bug.status == "Done"
    feeling
  end
end
