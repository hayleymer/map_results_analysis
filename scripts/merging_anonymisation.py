import pandas as pd

# Load assessment files
esp = pd.read_csv("data/AssessmentResultsESP.csv")
ess = pd.read_csv("data/AssessmentResultsESS.csv")
ms = pd.read_csv("data/AssessmentResultsMS.csv")

# Load student demographic files
espid = pd.read_csv("data/StudentsBySchoolESP.csv")
essid = pd.read_csv("data/StudentsBySchoolESS.csv")
msid = pd.read_csv("data/StudentsBySchoolMS.csv")

# Combine datasets
merged_student = pd.concat([esp, ess, ms], ignore_index=True)
merged_id = pd.concat([espid, essid, msid], ignore_index=True)

# Merge demographic info
merged_assessment = merged_student.merge(
    merged_id[["StudentID", "Grade", "StudentGender"]],
    on="StudentID",
    how="left"
)

# Create anonymised student ID
merged_assessment["anon_student_id"] = pd.factorize(merged_assessment["StudentID"])[0] + 1

# Defragment dataframe (performance tidy-up)
merged_assessment = merged_assessment.copy()

# Drop identifiable / unnecessary columns
merged_assessment = merged_assessment.drop(columns=[
    "DistrictName", "District_StateID",
    "SchoolName", "School_StateID",
    "StudentID", "Student_StateID"
])

# Export cleaned dataset
merged_assessment.to_csv("data/anonymised_assessment_MAP.csv", index=False)