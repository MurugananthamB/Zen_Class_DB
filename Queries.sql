-- 1. Find all the topics and tasks which are thought in the month of October

db.Topics.find({
  date: { $gte: ISODate("2023-10-01T00:00:00Z"), $lt: ISODate("2023-11-01T00:00:00Z") }
})

db.Tasks.find({
  date: { $gte: ISODate("2023-10-01T00:00:00Z"), $lt: ISODate("2023-11-01T00:00:00Z") }
})


--------------------------------------------------------------------------------------------------


-- 2. Find all the company drives which appeared between 15 oct-2020 and 31-oct-2020

db.Company_drives.find({
  date: { $gte: ISODate("2020-10-15T00:00:00Z"), $lt: ISODate("2020-11-01T00:00:00Z") }
})


--------------------------------------------------------------------------------------------------


-- 3. Find all the company drives and students who are appeared for the placement.

db.Company_drives.find({}, {
  company_name: 1,
  students_appeared: 1
})


--------------------------------------------------------------------------------------------------


-- 4. Find the number of problems solved by the user in codekata

db.Codekata.aggregate([
  { $group: { _id: "$user_id", total_problems_solved: { $sum: "$problems_solved" } } }
])


--------------------------------------------------------------------------------------------------


-- 5. Find all the mentors with who has the mentee's count more than 15

db.Mentors.find({
  mentees_count: { $gt: 15 }
})


--------------------------------------------------------------------------------------------------


-- 6. Find the number of users who are absent and task is not submitted  between 15 oct-2020 and 31-oct-2020

db.Users.find({
  $and: [
    {
      attendance: {
        
        -- attendance = Filters users who were absent between 15 Oct 2020 and 31 Oct 2020 by using $elemMatch to search inside the attendance array.
        
        $elemMatch: {
          date: {
            $gte: ISODate("2020-10-15T00:00:00Z"),
            $lte: ISODate("2020-10-31T23:59:59Z")
          },
          status: "absent"
        }
      }
    },
    {
        -- tasks_submitted: Checks if the user has a task that wasn't submitted within the same date range.

      tasks_submitted: {
        $elemMatch: {
          submitted: false,
          submission_date: {
            $gte: ISODate("2020-10-15T00:00:00Z"),
            $lte: ISODate("2020-10-31T23:59:59Z")
          }
        }
      }
    }
  ]
})


--------------------------------------------------------------------------------------------------

