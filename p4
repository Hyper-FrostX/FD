
import React from "react";

const studlist = [
  {
    slno: 1,
    name: "stud1",
    usn: "rvce1",
    tmarks: 150,
  },
  {
    slno: 2,
    name: "stud2",
    usn: "rvce2",
    tmarks: 145,
  },
];

// Component to display one student row
class StudentRow extends React.Component {
  render() {
    const studl = this.props.stdli;

    return (
      <tr>
        <td>{studl.slno}</td>
        <td>{studl.name}</td>
        <td>{studl.usn}</td>
        <td>{studl.tmarks}</td>
      </tr>
    );
  }
}

// Component to display the student table
class StudentsTable extends React.Component {
  render() {
    const studrows = this.props.studlist.map((studli) => (
      <StudentRow key={studli.slno} stdli={studli} />
    ));

    return (
      <table>
        <thead>
          <tr>
            <th>Sl No</th>
            <th>Student Name</th>
            <th>USN</th>
            <th>Total Marks</th>
          </tr>
        </thead>
        <tbody>{studrows}</tbody>
      </table>
    );
  }
}

// Component to add a new student
class StudentAddSubmit extends React.Component 
{
  constructor(props) {
    super(props);

    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();

    const form = e.target;

    const studli = {
      name: form.name.value.trim(),
      usn: form.usn.value.trim(),
      tmarks: Number(form.tmarks.value),
    };

    if (
      !studli.name ||
      !studli.usn ||
      form.tmarks.value.trim() === "" ||
      !Number.isFinite(studli.tmarks) ||
      studli.tmarks < 0
    ) {
      alert("Please enter valid student details.");
      return;
    }

    this.props.CreateStudentAdd(studli);
    form.reset();
  }

  render() {
    return (
      <form name="studAdd" onSubmit={this.handleSubmit}>
        <input
          type="text"
          name="name"
          placeholder="Student Name"
          required
        />

        <input
          type="text"
          name="usn"
          placeholder="USN"
          required
        />

        <input
          type="number"
          name="tmarks"
          placeholder="Total Marks"
          min="0"
          required
        />

        <button type="submit">Add Student</button>
      </form>
    );
  }
}

// Parent component: manages state and student registration
class StudentListTable extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      newStudList: [],
    };

    this.CreateStudentAdd = this.CreateStudentAdd.bind(this);
  }

  componentDidMount() {
    this.loadData();
  }

  loadData() {
    setTimeout(() => {
      this.setState({
        newStudList: studlist,
      });
    }, 1000);
  }

  CreateStudentAdd(studli) {
    this.setState((prevState) => ({
      newStudList: [
        ...prevState.newStudList,
        {
          ...studli,
          slno:
            prevState.newStudList.length > 0
              ? Math.max(
                  ...prevState.newStudList.map((s) => s.slno)
                ) + 1
              : 1,
        },
      ],
    }));
  }

  render() {
    return (
      <div className="container">
        <h1>Student Registration Portal</h1>

        <StudentsTable studlist={this.state.newStudList} />

        <h2>Add New Student</h2>

        <StudentAddSubmit
          CreateStudentAdd={this.CreateStudentAdd}
        />
      </div>
    );
  }
}

export default StudentListTable;


import React from "react";
import StudentListTable from "./student.js";

function App() {
  return <StudentListTable />;
}

export default App;

body {
  margin: 0;
  padding: 0;
  font-family: Arial, sans-serif;
  background-color: #f4f6f9;
}

.container {
  max-width: 900px;
  margin: 50px auto;
  padding: 25px;
  background-color: white;
  border-radius: 10px;
  box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
}

h1 {
  text-align: center;
  color: #173b72;
}

h2 {
  margin-top: 30px;
  color: #173b72;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 25px;
}

th,
td {
  border: 1px solid #ccc;
  padding: 12px;
  text-align: left;
}

th {
  background-color: #173b72;
  color: white;
}

tbody tr:nth-child(even) {
  background-color: #f0f4fa;
}

form {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 15px;
}

input {
  flex: 1;
  min-width: 140px;
  padding: 10px;
  border: 1px solid #bbb;
  border-radius: 5px;
}

button {
  padding: 10px 18px;
  border: none;
  border-radius: 5px;
  background-color: #173b72;
  color: white;
  cursor: pointer;
}

button:hover {
  background-color: #2457a0;
}
