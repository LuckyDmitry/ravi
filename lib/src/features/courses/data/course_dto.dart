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
        'imgUrl': imgUrl,
    };
}

class CourseSchemeDTO {
    String id;
    String title;
    BlockAndPage continueAt;
    List<CourseBlockSchemeDTO> blocks;

    CourseSchemeDTO({required this.id, required this.title, required this.continueAt, required this.blocks});

    factory CourseSchemeDTO.fromJson(Map<String, dynamic> json) => CourseSchemeDTO(
        id: json['id'],
        title: json['title'],
        continueAt: BlockAndPage(blockNumber: json["continueAt_blockNumber"], pageNumber: json["continueAt_pageNumber"]),
        blocks: List<CourseBlockSchemeDTO>.from(json['blocks'].map((x) => CourseBlockSchemeDTO.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'continueAt_blockNumber': continueAt.blockNumber,
        'continueAt_pageNumber': continueAt.pageNumber,
        'blocks': List<dynamic>.from(blocks.map((x) => x.toJson())),
    };
}

class BlockAndPage {
    int blockNumber;
    int pageNumber;
    BlockAndPage({required this.blockNumber, required this.pageNumber});
}

class CourseBlockSchemeDTO {
    int number;
    String title;
    bool isCompleted;
    List<PagePreviewDTO> pages;

    CourseBlockSchemeDTO({required this.number, required this.title, required this.isCompleted, required this.pages});

    factory CourseBlockSchemeDTO.fromJson(Map<String, dynamic> json) => CourseBlockSchemeDTO(
        number: json['number'],
        title: json['title'],
        isCompleted: json['isCompleted'],
        pages: List<PagePreviewDTO>.from(json['pages'].map((x) => PagePreviewDTO.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        'number': number,
        'title': title,
        'isCompleted': isCompleted,
        'pages': List<dynamic>.from(pages.map((x) => x.toJson())),
    };
}

class PageDTO {
    int number;
    String title;
    String content;
    bool completed;

    PageDTO({required this.number, required this.title, required this.content, this.completed = false});

    factory PageDTO.fromJson(Map<String, dynamic> json) => PageDTO(
        number: json['number'],
        title: json['title'],
        content: json['content'],
        completed: json['completed'],
    );

    Map<String, dynamic> toJson() => {
        'number': number,
        'title': title,
        'content': content,
        'completed': completed,
    };
}

class PagePreviewDTO {
    int number;
    String title;
    bool completed;

    PagePreviewDTO({required this.number, required this.title, this.completed = false});

    factory PagePreviewDTO.fromJson(Map<String, dynamic> json) => PagePreviewDTO(
        number: json['number'],
        title: json['title'],
        completed: json['completed'],
    );

    Map<String, dynamic> toJson() => {
        'number': number,
        'title': title,
        'completed': completed,
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
