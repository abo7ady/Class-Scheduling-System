# 📅 Class Scheduling System – Prolog Project

## 📘 Overview

**Class Scheduling System** is a Prolog-based logic program designed to automatically generate and validate course schedules for students.
The project ensures that student timetables are **conflict-free**, follow specific constraints such as **two days off per week**, and provides tools to analyze and query different scheduling aspects.

This project was developed as part of the *Concepts of Programming Languages* course at the **German University in Cairo (Spring 2025)**.

---

## 🧠 Features

* ✅ Automatically generate schedules for all registered students
* ✅ Ensure no overlapping course slots (no clashes)
* ✅ Guarantee each student has **2 days off per week**
* ✅ Retrieve schedules for individual students
* ✅ Identify time slots where **all students are free** (assembly hours)

---

## 📂 Project Structure

```
.
├── Knoweldge Base.pl            # Knowledge base containing students and course schedules
├── University Scheduling        # Main Prolog project
└── README.md                    # Project documentation
```

> 💡 **Note:** The `Knoweldge Base.pl` file must be in the same directory as `University Scheduling` so that it can be consulted automatically.

---

## 🛠️ Main Predicates

### 1. `university_schedule(S)`

* **Purpose:** Generate the complete schedule for all students.
* **Output:** `S` is bound to a list of schedules, one for each student.
* **Structure:**

  ```prolog
  sched(StudentID, [slot(Day, SlotNumber, CourseCode), ...])
  ```
* **Example:**

  ```prolog
  ?- university_schedule(S).
  S = [sched(student_0, [slot(saturday, 2, csen202), ...]), ...].
  ```

---

### 2. `student_schedule(StudentID, Slots)`

* **Purpose:** Retrieve the schedule for a specific student.
* **Output:** `Slots` is a list of the student’s course slots.
* **Example:**

  ```prolog
  ?- student_schedule(student_0, Slots).
  Slots = [slot(saturday, 2, csen202), slot(sunday, 2, mech202), ...].
  ```

---

### 3. `no_clashes(Slots)`

* **Purpose:** Check that no two courses in a given schedule clash (i.e., occur in the same day and slot).
* **Output:** Succeeds if there are no clashes, fails otherwise.
* **Example:**

  ```prolog
  ?- no_clashes([slot(saturday, 1, physics201), slot(sunday, 1, mech202)]).
  true.

  ?- no_clashes([slot(saturday, 1, physics201), slot(saturday, 1, csen202)]).
  false.
  ```

---

### 4. `study_days(Slots, DayCount)`

* **Purpose:** Check if the schedule uses no more than a given number of study days.
* **Use case:** Ensures students have **two days off**.
* **Example:**

  ```prolog
  ?- study_days(Slots, 4).
  true.

  ?- study_days(Slots, 2).
  false.
  ```

---

### 5. `assembly_hours(Schedules, AH)`

* **Purpose:** Find all **time slots where all students are free** on their study days.
* **Output:** `AH` is a list of free slots common to all students.
* **Structure:**

  ```prolog
  slot(Day, SlotNumber)
  ```
* **Example:**

  ```prolog
  ?- assembly_hours(Schedules, AH).
  AH = [slot(saturday, 3), slot(saturday, 4), slot(saturday, 5)].
  ```

---

## ▶️ Running the Project

1. Make sure you have **SWI-Prolog** installed.
2. Place `University Scheduling` and `Konwledge Base.pl` in the same directory.
3. Open a terminal and run:

   ```bash
   swipl
   ```
4. Load the project:

   ```prolog
   ?- [schedule].
   ```
5. Try out queries like:

   ```prolog
   ?- university_schedule(S).
   ?- student_schedule(student_0, Slots).
   ?- no_clashes(Slots).
   ?- study_days(Slots, 4).
   ?- assembly_hours(Schedules, AH).
   ```

---

## 📚 Notes

* The project uses only **declarative logic** and **built-in Prolog predicates** (no `assert` or `retract`).

---

## 🏁 Final Thoughts

## This project demonstrates how **declarative programming** and **logic reasoning** can be applied to real-world scheduling problems. By combining a knowledge base with Prolog inference, we can build powerful scheduling tools with minimal imperative logic.
