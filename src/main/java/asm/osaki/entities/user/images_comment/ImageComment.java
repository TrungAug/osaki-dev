package asm.osaki.entities.user.images_comment;

import asm.osaki.entities.user.Comment;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "image_comment_entity")
@Data
public class ImageComment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private String imageName;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    private Boolean isDelete;

    @ManyToOne
    @JoinColumn(name = "images")
    private Comment commentID;
}
