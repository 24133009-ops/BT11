package model;

import javax.persistence.*;

@Entity
@Table(name = "users")
public class User_24133009 {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "email", length = 50, nullable = false)
    private String email;

    @Column(name = "fullname", length = 50)
    private String fullname;

    @Column(name = "phone")
    private Integer phone;

    @Column(name = "passwd", length = 32, nullable = false)
    private String passwd;

    @Column(name = "signup_date")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date signupDate;

    @Column(name = "last_login")
    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date lastLogin;

    @Column(name = "is_admin")
    private Boolean isAdmin;

    // Constructors
    public User_24133009() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public Integer getPhone() { return phone; }
    public void setPhone(Integer phone) { this.phone = phone; }

    public String getPasswd() { return passwd; }
    public void setPasswd(String passwd) { this.passwd = passwd; }

    public java.util.Date getSignupDate() { return signupDate; }
    public void setSignupDate(java.util.Date signupDate) { this.signupDate = signupDate; }

    public java.util.Date getLastLogin() { return lastLogin; }
    public void setLastLogin(java.util.Date lastLogin) { this.lastLogin = lastLogin; }

    public Boolean getIsAdmin() { return isAdmin; }
    public void setIsAdmin(Boolean isAdmin) { this.isAdmin = isAdmin; }
}
