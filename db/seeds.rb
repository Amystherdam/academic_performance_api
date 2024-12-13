# frozen_string_literal: true

if Rails.env.development?
  # Creating students
  spinner_student = TTY::Spinner.new("[:spinner] Creating student ...")
  spinner_student.auto_spin

  15.times do
    Student.create!(
      name: Faker::Name.name,
    )
  end

  spinner_student.success("[OK!]")

  # Creating cicles
  spinner_cicle = TTY::Spinner.new("[:spinner] Creating cicles ...")
  spinner_cicle.auto_spin

  15.times do
    Cicle.find_or_create_by(
      month: Random.rand(0..11),
      year: Random.rand(2024..2026),
    )
  end

  spinner_cicle.success("[OK!]")

  # Creating subjects
  spinner_subject = TTY::Spinner.new("[:spinner] Creating subjects ...")
  spinner_subject.auto_spin

  4.times do
    subject = Subject.find_or_create_by(
      name: Faker::Educator.subject,
      calculation_type: Random.rand(0..1),
    )

    subject.days_interval = Random.rand(90..365) if subject.calculation_type == :last_days_average
  end

  spinner_subject.success("[OK!]")

  # Creating grades
  spinner_grade = TTY::Spinner.new("[:spinner] Creating grades ...")
  spinner_grade.auto_spin

  Student.find_each do |student|
    Subject.find_each do |subject|
      5.times do
        Grade.create!(
          student:,
          subject:,
          obtained: Faker::Number.decimal(l_digits: 2),
        )
      end
    end
  end

  spinner_grade.success("[OK!]")
end
