# Personalized Exams with Quarto and R

This directory contains a template with the bare minimum code to create parameterized exams. At the moment, this is only meant to be for placing a student's name on every page, although this could potentially be extended to creating a unique exam for every student (e.g., maybe there are three versions of every question, A, B, and C, and students get a randomly generated exam like AAACBA, BBCCAA, CCABAB, etc.). 

Instructions: 

* Quarto Edits
	* The current naming scheme is mostly irrelevant; I personally use the naming convention
		* STAT (my department code)
		* XXX (a course number, like 220)
		* QQ (the grading period, like SP, AU, WI, SU, etc.)
		* YY (Year)
		* Exam (the name of the exam, like Midterm, Final)
	* Whatever you rename the file, make sure to change the name on line 35, `input = "STAT-XXX-QQYY-Exam.qmd",` accordingly. 
	* You'll also want to change the exam prefix as well on line 29, `"STAT-XXX-QQYY-Exam-"`. 
		* Exams will come out named `"STAT-XXX-QQYY-Exam-Z-Last-First.pdf"`, where `Z`, `Last`, and `First` come from your `roster.csv`. 
		* Make sure to change the exam descriptors in the YAML, line 11
		* Finally, your normal exam text a `setup` code chunk, etc, should start on line 46+. 
* Roster Edits
	* Edit the `roster.csv` file with your own roster.
	* The `Last` and `First` fields are as usual. I put my roster in alphabetical order by last name.
	* The `ID` field is whatever you'd like. I use numbers $1$ through $n$ to make it easier for sorting and/or checking whether I have all exams. 
	* The `Exam` field is somewhat optional. I use this to denote whether the exam is in-class or with our testing center, `SDS`. 
		* In the Quarto file, I sometimes filter the roster on whether the student is `SDS` or `In-class`. 
* Exam Writing
	* Write your exam as usual. As you edit the file, you can press the "render" button in RStudio to see what a generic blank copy looks like.
* Personalized Exam Rendering
	* Now, when you are done with your roster and the `.QMD` (make sure both are saved!), you can render the exam for every student!
	* Just press the "play" button in the `render_chunk` (currently line 22) to run all of the code.
	* It will take some amount of time to render all of the exams. Do something else!
	
You may want to test that this works on your machine first by rendering the generic exam and then pressing the "play" button in the `render_chunk` to see whether three example exams come out in the `printing` folder. 

Note: in case you weren't sure -- the placeholder roster included here includes a famous and [all-time great trio of San Antonio Spurs](https://en.wikipedia.org/wiki/Big_Three_(San_Antonio_Spurs))! 