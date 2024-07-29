package asm.osaki.entities.product;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "news")
@Data
public class News {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Nationalized
    @Column(columnDefinition = "nvarchar(MAX)")
    private String title;

    private String userID;

    @Temporal(TemporalType.DATE)
    @Column(name = "dateAt")
    private Date dateAt = new Date();

    private String images;
    @Nationalized
    @Column(columnDefinition = "nvarchar(MAX)")
    private String message;
}
