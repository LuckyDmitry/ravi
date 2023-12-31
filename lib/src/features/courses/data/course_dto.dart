class CoursePreviewDTO {
    String courseId;
    String title;
    String description;
    String imgUrl;

    CoursePreviewDTO({required this.courseId, required this.title, this.description = '', required this.imgUrl});

    factory CoursePreviewDTO.fromJson(Map<String, dynamic> json) => CoursePreviewDTO(
        courseId: json['courseId'],
        title: json['title'],
        description: json['description'],
        imgUrl: json['imgUrl'],
    );

    Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'title': title,
        'description': description,
        'imgUrl': imgUrl,
    };
}

class CourseSchemeDTO {

    String courseId;
    String title;
    List<PagePreviewDTO> pages;

    CourseSchemeDTO({required this.courseId, required this.title, required this.pages});

    factory CourseSchemeDTO.fromJson(Map<String, dynamic> json) => CourseSchemeDTO(
      courseId: json['courseId'],
        title: json['title'],
        pages: List<PagePreviewDTO>.from(json['pages'].map((x) => PagePreviewDTO.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'title': title,
        'pages': List<dynamic>.from(pages.map((x) => x.toJson())),
    };
}

class PagePreviewDTO {
    String pageId;
    String title;

    PagePreviewDTO({required this.pageId, required this.title});

    factory PagePreviewDTO.fromJson(Map<String, dynamic> json) => PagePreviewDTO(
        pageId: json['pageId'],
        title: json['title'],
    );

    Map<String, dynamic> toJson() => {
        'pageId': pageId,
        'title': title
    };
}

class PageDTO {
    String pageId;
    String title;
    String content;

    PageDTO({required this.pageId, required this.title, required this.content});

    factory PageDTO.fromJson(Map<String, dynamic> json) => PageDTO(
        pageId: json['pageId'],
        title: json['title'],
        content: json['content']
    );

    Map<String, dynamic> toJson() => {
        'pageId': pageId,
        'title': title,
        'content': content
    };
}

class TaskSubmissionDTO {
    int attempt;
    Map<String, dynamic> content;
    Map<String, dynamic> chatGptHints;
    String status;
    String solvedAt;
    String lastAttemptAt;

    TaskSubmissionDTO({
        required this.attempt,
        required this.content,
        required this.chatGptHints,
        required this.status,
        this.solvedAt = '',
        required this.lastAttemptAt
    });

    factory TaskSubmissionDTO.fromJson(Map<String, dynamic> json) => TaskSubmissionDTO(
        attempt: json['attempt'],
        content: json['content'],
        chatGptHints: json['chat_gpt_hints'],
        status: json['status'],
        solvedAt: json['solved_at'],
        lastAttemptAt: json['last_attempt_at'],
    );

    Map<String, dynamic> toJson() => {
        'attempt': attempt,
        'content': content,
        'chat_gpt_hints': chatGptHints,
        'status': status,
        'solved_at': solvedAt,
        'last_attempt_at': lastAttemptAt,
    };
}

class TaskDTO {
    String id;
    String title;
    String description;
    String taskType;
    TaskSubmissionDTO lastSubmission;

    TaskDTO({required this.id, required this.title, this.description = '', required this.taskType, required this.lastSubmission});

    factory TaskDTO.fromJson(Map<String, dynamic> json) => TaskDTO(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        taskType: json['task_type'],
        lastSubmission: TaskSubmissionDTO.fromJson(json['last_submission']),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'task_type': taskType,
        'last_submission': lastSubmission.toJson(),
    };
}

class TaskSubmissionPreviewDTO {
    int attempt;
    String status;
    String solvedAt;
    String lastAttemptAt;

    TaskSubmissionPreviewDTO({
        required this.attempt,
        required this.status,
        this.solvedAt = '',
        required this.lastAttemptAt
    });

    factory TaskSubmissionPreviewDTO.fromJson(Map<String, dynamic> json) => TaskSubmissionPreviewDTO(
        attempt: json['attempt'],
        status: json['status'],
        solvedAt: json['solved_at'],
        lastAttemptAt: json['last_attempt_at'],
    );

    Map<String, dynamic> toJson() => {
        'attempt': attempt,
        'status': status,
        'solved_at': solvedAt,
        'last_attempt_at': lastAttemptAt,
    };
}
