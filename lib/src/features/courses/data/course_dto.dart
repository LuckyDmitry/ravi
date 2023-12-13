class CourseDTO {
    String id;
    String title;
    String description;
    List<CourseBlockDTO> blocks;

    CourseDTO({required this.id, required this.title, this.description = '', required this.blocks});

    factory CourseDTO.fromJson(Map<String, dynamic> json) => CourseDTO(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        blocks: List<CourseBlockDTO>.from(json['blocks'].map((x) => CourseBlockDTO.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'blocks': List<dynamic>.from(blocks.map((x) => x.toJson())),
    };
}
class CoursePreviewDTO {
    String id;
    String title;
    String description;
    String imgUrl;

    CoursePreviewDTO({required this.id, required this.title, this.description = '', required this.imgUrl});

    factory CoursePreviewDTO.fromJson(Map<String, dynamic> json) => CoursePreviewDTO(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        imgUrl: json['imgUrl'],
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
    };
}

class CourseBlockDTO {
    int number;
    String title;
    String description;
    List<PageDTO> pages;

    CourseBlockDTO({required this.number, required this.title, this.description = '', required this.pages});

    factory CourseBlockDTO.fromJson(Map<String, dynamic> json) => CourseBlockDTO(
        number: json['number'],
        title: json['title'],
        description: json['description'],
        pages: List<PageDTO>.from(json['pages'].map((x) => PageDTO.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'number': number,
        'title': title,
        'description': description,
        'pages': List<dynamic>.from(pages.map((x) => x.toJson())),
    };
}

class PageDTO {
    int number;
    String title;
    String content;
    bool completed;
    TaskDTO task;

    PageDTO({required this.number, required this.title, required this.content, this.completed = false, required this.task});

    factory PageDTO.fromJson(Map<String, dynamic> json) => PageDTO(
        number: json['number'],
        title: json['title'],
        content: json['content'],
        completed: json['completed'],
        task: TaskDTO.fromJson(json['task']),
    );

    Map<String, dynamic> toJson() => {
        'number': number,
        'title': title,
        'content': content,
        'completed': completed,
        'task': task.toJson(),
    };
}

class PagePreviewDTO {
    String title;
    bool completed;
    bool containsTask;

    PagePreviewDTO({required this.title, this.completed = false, this.containsTask = false});

    factory PagePreviewDTO.fromJson(Map<String, dynamic> json) => PagePreviewDTO(
        title: json['title'],
        completed: json['completed'],
        containsTask: json['contains_task'],
    );

    Map<String, dynamic> toJson() => {
        'title': title,
        'completed': completed,
        'contains_task': containsTask,
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
