const Student = function Student(fname, lname) {
  this.fname = fname;
  this.lname = lname;
  this.courses = [];
};

Student.prototype.name = function name() {
  return `${this.fname} ${this.lname}`;
};

Student.prototype.enroll = function enroll(course) {
  if(!this.courses.includes(course) && !this.hasConflict(course)) {
    this.courses.push(course);
    course.addStudent(this);
  }
};

Student.prototype.courseLoad = function courseLoad() {
  let count = {};
  for(let i = 0; i < this.courses.length; i++) {
    let course = this.courses[i];
    if(count[course.department] === undefined) {
      count[course.department] = course.credits;
    } else {
      count[course.department] += course.credits;
    }
  }

  return count;
};

Student.prototype.hasConflict = function hasConflict(course)
{
  for(let i = 0; i < this.courses.length; i++)
  {
    if(this.courses[i].conflictsWith(course))
    {
      return true;
    }
  }
  return false;
}


const Course = function Course(name, department, credits, days, time) {
  this.name = name;
  this.department = department;
  this.credits = credits;
  this.days = days;
  this.time = time;
  this.students = [];
};

Course.prototype.addStudent = function addStudent(student) {
  this.students.push(student);
};

Course.prototype.conflictsWith = function conflictsWith(course)
{
  if(course.time !== this.time)
  {
    return false;
  }
  for(let i = 0; i < this.days.length; i++)
  {
    for(let j = 0; j < course.days.length; j++)
    {
      if(course.days[j] === this.days[i])
      {
        return true;
      }
    }
  }
  return false;
}









// ...
