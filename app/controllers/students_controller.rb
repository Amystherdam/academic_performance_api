# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :set_student, only: [:parcial_grades, :final_grades]

  # GET /students
  def index
    overall_student_grades = OverallStudentGrade.joins(:cicle).includes(:student).where(cicles: {
      month: (Time.now.utc - 1.month).month,
      year: Time.now.utc.year,
    })

    render(json: overall_student_grades.map do |overall_student_grade|
      {
        id: overall_student_grade.student.id,
        name: overall_student_grade.student.name,
        obtained: overall_student_grade.obtained,
      }
    end)
  end

  # GET /students/1
  # def show
  #   render(json: @student)
  # end

  # POST /students
  # def create
  #   @student = Student.new(student_params)

  #   if @student.save
  #     render(json: @student, status: :created, location: @student)
  #   else
  #     render(json: @student.errors, status: :unprocessable_entity)
  #   end
  # end

  # PATCH/PUT /students/1
  # def update
  #   if @student.update(student_params)
  #     render(json: @student)
  #   else
  #     render(json: @student.errors, status: :unprocessable_entity)
  #   end
  # end

  # DELETE /students/1
  # def destroy
  #   @student.destroy!
  # end

  # GET /students/1/parcial_grades
  def parcial_grades
    grades = Grade.includes(:student, :subject).where(student_id: @student.id)

    render(json: grades.map do |grade|
      {
        student_id: grade.student.id,
        student_name: grade.student.name,
        subject_name: grade.subject.name,
        obtained: grade.obtained,
      }
    end)
  end

  # GET /students/1/final_grades
  def final_grades
    grades = StudentSubjectCicle.joins(:cicle).includes(:student, :subject, :cicle).where(
      student_id: @student.id,
      cicles: { month: (Time.now.utc - 1.month).month, year: Time.now.utc.year },
    )

    render(json: grades.map do |grade|
      {
        student_id: grade.student.id,
        student_name: grade.student.name,
        subject_name: grade.subject.name,
        obtained: grade.obtained,
      }
    end)
  end

  # GET /students/bests
  def bests
    overall_student_grades = OverallStudentGrade.joins(:cicle).includes(:student).where(cicles: {
      month: (Time.now.utc - 1.month).month,
      year: Time.now.utc.year,
    }).order(obtained: :desc).limit(student_params[:size] || 5)

    render(json: overall_student_grades.map do |overall_student_grade|
      {
        student_id: overall_student_grade.student.id,
        student_name: overall_student_grade.student.name,
        obtained: overall_student_grade.obtained,
      }
    end)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.permit(:size)
  end
end
