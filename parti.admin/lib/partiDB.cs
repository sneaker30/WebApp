using System;
using System.Collections.Generic;

namespace parti.admin.lib
{
    public class partiDB
    {
        public class GetAuthen
        {
            public string tid { get; set; }
            public string id { get; set; }
            public string username { get; set; }
            public string passwd { get; set; }
            public string rules { get; set; }
            public string user_avatar { get; set; }
            public string fullname { get; set; }
            public string position { get; set; }
        }

        public class SumYearlyCourse
        {
            public string course;
            public int total;
        }

        public class GetUsers
        {
            public int id { get; set; }
            public string username { get; set; }
            public string passwd { get; set; }
            public string rules { get; set; }
        }

        public class GetCourse
        {
            public int id { get; set; }
            public string name { get; set; }
            public string description { get; set; }
        }

        public class GetTrainerList
        {

            public string id { get; set; }
            public string fullname_la { get; set; }
            public string fullname_eng { get; set; }
            public DateTime date_of_birth { get; set; }
            public string sex { get; set; }
            public string status { get; set; }
            public string village { get; set; }
            public string district { get; set; }
            public string province { get; set; }
            public string work_place { get; set; }
            public string department { get; set; }
            public string position { get; set; }
            public DateTime date_of_govermented { get; set; }
            public string office_tel { get; set; }
            public string mobile_tel { get; set; }
            public string email { get; set; }
            public string avatar_url { get; set; }
            public string doc1_url { get; set; }
            public string doc2_url { get; set; }
            public string doc3_url { get; set; }
            public string doc4_url { get; set; }
            public string doc5_url { get; set; }
            public string username { get; set; }
            public string education_level { get; set; }
            public string education_major { get; set; }
            public string education_country { get; set; }
            public string educated_year { get; set; }
            public string education_name { get; set; }
        }

        public class GetUserProfile
        {
            public int id { get; set; } //user id
            public string name { get; set; } //trainer id
            public string faminame { get; set; }
            public DateTime date_of_birth { get; set; }
            public string sex { get; set; }
            public string work_place { get; set; }
            public string position { get; set; }
            public string picture_url { get; set; }
            public string userame { get; set; }
            public string lv1 { get; set; }
            public string lv2 { get; set; }
            public string lv3 { get; set; }
            public string lv4 { get; set; }
            public string lv5 { get; set; }
        }

        public class GetTraineeList
        {
            public string id { get; set; }
            public string fullname_la { get; set; }
            public string fullname_eng { get; set; }
            public DateTime date_of_birth { get; set; }
            public string sex { get; set; }
            public string status { get; set; }
            public string village { get; set; }
            public string district { get; set; }
            public string province { get; set; }
            public string work_place { get; set; }
            public string department { get; set; }
            public string position { get; set; }
            public DateTime date_of_govermented { get; set; }
            public string office_tel { get; set; }
            public string mobile_tel { get; set; }
            public string email { get; set; }
            public string avatar_url { get; set; }
            public string approval_id { get; set; }
            public string doc1_url { get; set; }
            public string doc2_url { get; set; }
            public string doc3_url { get; set; }
            public string doc4_url { get; set; }
            public string doc5_url { get; set; }
            public string appr_id { get; set; }
            public string appr_fullname { get; set; }
            public string appr_position_name { get; set; }
            public string appr_position_major { get; set; }
            public string appr_relationship_trainee { get; set; }
            public string appr_office_name { get; set; }
            public string appr_office_tel { get; set; }
            public string appr_mobile_tel { get; set; }
            public string appr_email { get; set; }
            public string education_level { get; set; }
            public string education_major { get; set; }
            public string education_country { get; set; }
            public string educated_year { get; set; }
            public string education_name { get; set; }
        }

        public class GetTrainingList
        {
            public string id { get; set; }
            public string title { get; set; }
            public int course_id { get; set; }
            public string course_name { get; set; }
            public string int_or_ext { get; set; }
            public string training_address { get; set; }
            public string training_district { get; set; }
            public string training_province { get; set; }
            public int training_days { get; set; }
            public DateTime training_date { get; set; }
            public string description { get; set; }
            public DateTime date_of_modified_date { get; set; }
        }

        public class GetTraineeByTraining
        {
            public string training_id { get; set; }
            public string trainee_id { get; set; }
            public string fullname { get; set; }
            public string work_place { get; set; }
        }

        public class GetTrainerByTraining
        {
            public string training_id { get; set; }
            public string trainer_id { get; set; }
            public string fullname { get; set; }
            public string work_place { get; set; }
        }

        public class GetYearPlan
        {
            public int id { get; set; }
            public string year_plan { get; set; }
            public string course_id { get; set; }
            public int target { get; set; }
        }

        public class GetCompareYearPlan
        {
            public string PlanType { get; set; }
            public string CourseID { get; set; }
            public string CourseName { get; set; }
            public string Targets { get; set; }
            public string DoneTarget { get; set; }
        }

        public class GetTrainingIDName
        {
            public string id { get; set; }
            public string title { get; set; }
        }

        public class GetVillage
        {
            public string v_id { get; set; }
            public string v_name { get; set; }
            public string d_id { get; set; }
            public string p_id { get; set; }
        }

        public class GetDistrict
        {
            public string d_id { get; set; }
            public string d_name { get; set; }
            public string p_id { get; set; }
        }

        public class GetProvince
        {
            public string p_id { get; set; }
            public string p_name { get; set; }
        }

        public class GetTrainingExperience
        {
            public string training_id { get; set; }
            public string title { get; set; }
            public string int_or_ext { get; set; }
            public string address { get; set; }
            public DateTime training_date { get; set; }
            public string trainee_id { get; set; }
        }

        public class GetTrainingExperience_Trainer
        {
            public string training_id { get; set; }
            public string title { get; set; }
            public string int_or_ext { get; set; }
            public string address { get; set; }
            public DateTime training_date { get; set; }
            public string trainer_id { get; set; }
        }

        public class GetExperience
        {
            public string id { get; set; }
            public string experience_id { get; set; }
            public string responsibility { get; set; }
            public string office { get; set; }
            public string years { get; set; }
        }

        public class CheckTraineeForTraining
        {
            public string id { get; set; }
            public string trainee_id { get; set; }
            public string course_id { get; set; }
            public string course_name { get; set; }
            public string title { get; set; }
            public string training_address { get; set; }
            public DateTime training_date { get; set; }
            public string code { get; set; }
        }

        public class GetQTitle
        {
            public string t_id { get; set; }
            public string title_name { get; set; }
            public string training_id { get; set; }
            public DateTime date_of_modified_data { get; set; }
            public string q_type { get; set; }
        }

        public class GetQQuestion
        {
            public string q_id { get; set; }
            public string question_text { get; set; }
            public string t_id { get; set; }
            public string date_of_modified_date { get; set; }
        }

        public class GetQAnswer
        {
            public string a_id { get; set; }
            public string answer_text { get; set; }
            public string q_id { get; set; }
            public string t_id { get; set; }
            public string status { get; set; }
            public string date_of_modified_date { get; set; }
        }

        public class trainingrpt01
        {
            public string course_id { get; set; }
            public string course_name { get; set; }
            public string training_id { get; set; }
            public string title { get; set; }
            public string total_trainee { get; set; }
            public string date_range { get; set; }
            public string organizer { get; set; }
            public string total_event { get; set; }
            public string training_address { get; set; }
            public string total_trainee_fmale { get; set; }
        }

        public class RootObject
        {
            public List<trainingrpt01> trainingrpt01 { get; set; }
            public List<GetQAnswer> GetQAnswer { get; set; }
            public List<GetQQuestion> GetQQuestion { get; set; }
            public List<GetQTitle> GetQTitle { get; set; }
            public List<CheckTraineeForTraining> CheckTraineeForTraining { get; set; }
            public List<GetTrainingExperience_Trainer> GetTrainingExperience_Trainer { get; set; }
            public List<GetExperience> GetExperience { get; set; }
            public List<GetTrainingExperience> GetTrainingExperience { get; set; }
            public List<GetVillage> GetVillage { get; set; }
            public List<GetDistrict> GetDistrict { get; set; }
            public List<GetProvince> GetProvince { get; set; }
            public List<GetCompareYearPlan> GetCompareYearPlan { get; set; }
            public List<GetAuthen> GetAuthen { get; set; }
            public List<SumYearlyCourse> SumYearlyCourse { get; set; }
            public List<GetUsers> GetUsers { get; set; }
            public List<GetCourse> GetCourse { get; set; }
            public List<GetTrainerList> GetTrainerList { get; set; }
            public List<GetUserProfile> GetUserProfile { get; set; }
            public List<GetTraineeList> GetTraineeList { get; set; }
            public List<GetTrainingList> GetTrainingList { get; set; }
            public List<GetTraineeByTraining> GetTraineeByTraining { get; set; }
            public List<GetTrainerByTraining> GetTrainerByTraining { get; set; }
            public List<GetYearPlan> GetYearPlans { get; set; }
            public List<GetTrainingIDName> GetTrainingIDName { get; set; }
        }
    }
}