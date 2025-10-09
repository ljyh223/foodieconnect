
-- TableTalk 数据库初始化脚本
-- 版本: 1.0
-- 创建日期: 2024-01-15

-- 创建数据库
CREATE DATABASE IF NOT EXISTS tabletalk CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE tabletalk;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    display_name VARCHAR(100),
    avatar_url VARCHAR(500),
    password_hash VARCHAR(255) NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE', 'BANNED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 餐厅表
CREATE TABLE IF NOT EXISTS restaurants (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    type VARCHAR(100) NOT NULL,
    distance VARCHAR(50),
    description TEXT,
    address VARCHAR(500) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    hours VARCHAR(100),
    rating DECIMAL(3,2) DEFAULT 0.00,
    review_count INT DEFAULT 0,
    is_open BOOLEAN DEFAULT TRUE,
    avatar VARCHAR(10),
    latitude DECIMAL(10,8),
    longitude DECIMAL(11,8),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_type (type),
    INDEX idx_rating (rating),
    INDEX idx_is_open (is_open),
    INDEX idx_location (latitude, longitude)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 推荐菜品表
CREATE TABLE IF NOT EXISTS recommended_dishes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT NOT NULL,
    dish_name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2),
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    INDEX idx_restaurant_id (restaurant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 店员表
CREATE TABLE IF NOT EXISTS staff (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    status ENUM('ONLINE', 'OFFLINE', 'BUSY') DEFAULT 'OFFLINE',
    experience VARCHAR(50),
    rating DECIMAL(3,2) DEFAULT 0.00,
    avatar_url VARCHAR(500),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    INDEX idx_restaurant_id (restaurant_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 店员技能表
CREATE TABLE IF NOT EXISTS staff_skills (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    INDEX idx_staff_id (staff_id),
    UNIQUE KEY uk_staff_skill (staff_id, skill_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 店员语言表
CREATE TABLE IF NOT EXISTS staff_languages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT NOT NULL,
    language VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    INDEX idx_staff_id (staff_id),
    UNIQUE KEY uk_staff_language (staff_id, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 评论表
CREATE TABLE IF NOT EXISTS reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    helpful_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_restaurant_id (restaurant_id),
    INDEX idx_user_id (user_id),
    INDEX idx_created_at (created_at),
    UNIQUE KEY uk_user_restaurant (user_id, restaurant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 评论回复表
CREATE TABLE IF NOT EXISTS review_replies (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    review_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (review_id) REFERENCES reviews(id) ON DELETE CASCADE,
    INDEX idx_review_id (review_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 店员评论表
CREATE TABLE IF NOT EXISTS staff_reviews (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    staff_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    rating DECIMAL(3,2) NOT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_staff_id (staff_id),
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 聊天会话表
CREATE TABLE IF NOT EXISTS chat_sessions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT NOT NULL,
    staff_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    status ENUM('ACTIVE', 'CLOSED', 'EXPIRED') DEFAULT 'ACTIVE',
    last_message TEXT,
    last_message_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    unread_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_staff (user_id, staff_id),
    INDEX idx_restaurant_id (restaurant_id),
    INDEX idx_user_id (user_id),
    INDEX idx_staff_id (staff_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 聊天消息表
CREATE TABLE IF NOT EXISTS chat_messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    session_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    sender_type ENUM('USER', 'STAFF') NOT NULL,
    content TEXT NOT NULL,
    message_type ENUM('TEXT', 'IMAGE', 'SYSTEM') DEFAULT 'TEXT',
    image_url VARCHAR(500),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES chat_sessions(id) ON DELETE CASCADE,
    INDEX idx_session_id (session_id),
    INDEX idx_sender_id (sender_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 餐厅特色表
CREATE TABLE IF NOT EXISTS restaurant_features (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id BIGINT NOT NULL,
    feature_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id) ON DELETE CASCADE,
    INDEX idx_restaurant_id (restaurant_id),
    UNIQUE KEY uk_restaurant_feature (restaurant_id, feature_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 插入测试数据

-- 插入测试用户 (密码都是: password123)
INSERT INTO users (email, phone, display_name, avatar_url, password_hash) VALUES
('user1@example.com', '13800138001', '张三', 'https://example.com/avatar1.jpg', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTV5UiC'),
('user2@example.com', '13800138002', '李四', 'https://example.com/avatar2.jpg', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTV5UiC'),
('user3@example.com', '13800138003', '王五', 'https://example.com/avatar3.jpg', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTV5UiC');

-- 插入测试餐厅
INSERT INTO restaurants (name, type, distance, description, address, phone, hours, rating, review_count, is_open, avatar, latitude, longitude) VALUES
('川味轩', '川菜', '500m', '正宗川菜，麻辣鲜香，环境优雅', '市中心街道123号', '(021) 1234-5678', '10:00 - 22:00', 4.8, 128, TRUE, '川', 31.230416, 121.473701),
('粤港茶餐厅', '粤菜', '800m', '地道港式茶餐厅，点心精美', '市中心街道456号', '(021) 2345-6789', '09:00 - 23:00', 4.6, 96, TRUE, '粤', 31.231416, 121.474701),
('意大利餐厅', '西餐', '1.2km', '正宗意大利风味，浪漫用餐环境', '市中心街道789号', '(021) 3456-7890', '11:00 - 22:30', 4.7, 85, TRUE, '意', 31.232416, 121.475701),
('和风料理', '日料', '600m', '新鲜刺身，精致日式料理', '市中心街道101号', '(021) 4567-8901', '11:30 - 22:00', 4.9, 102, TRUE, '日', 31.233416, 121.476701);

-- 插入推荐菜品
INSERT INTO recommended_dishes (restaurant_id, dish_name, description, price) VALUES
(1, '宫保鸡丁', '经典川菜，麻辣鲜香', 48.00),
(1, '麻婆豆腐', '麻辣鲜香，豆腐嫩滑', 32.00),
(1, '水煮鱼', '鲜嫩鱼肉，麻辣过瘾', 68.00),
(2, '烧腊双拼', '烧鸭叉烧，香气四溢', 58.00),
(2, '鲜虾云吞面', '鲜虾云吞，汤底鲜美', 35.00),
(3, '意大利面', '正宗意面，酱料浓郁', 45.00),
(3, '披萨', '薄底披萨，配料丰富', 65.00),
(4, '刺身拼盘', '新鲜刺身，品种多样', 128.00),
(4, '寿司', '精致寿司，口感丰富', 88.00);

-- 插入餐厅特色
INSERT INTO restaurant_features (restaurant_id, feature_name) VALUES
(1, '免费WiFi'),
(1, '包间预订'),
(1, '停车位'),
(1, '外卖服务'),
(2, '免费WiFi'),
(2, '早茶服务'),
(2, '外卖服务'),
(3, '浪漫氛围'),
(3, '红酒推荐'),
(3, '生日优惠'),
(4, '日式包间'),
(4, '清酒推荐'),
(4, '外卖服务');

-- 插入店员数据
INSERT INTO staff (restaurant_id, name, position, status, experience, rating, avatar_url, description) VALUES
(1, '小张', '服务员', 'ONLINE', '3年', 4.9, '张', '热情周到的服务，熟悉各类菜品特点'),
(1, '小李', '经理', 'BUSY', '5年', 4.8, '李', '经验丰富的餐厅经理，擅长客户服务'),
(2, '小王', '服务员', 'ONLINE', '2年', 4.7, '王', '细心体贴，熟悉粤菜特色'),
(3, '小陈', '服务员', 'OFFLINE', '4年', 4.9, '陈', '熟悉西餐礼仪，服务专业'),
(4, '小林', '服务员', 'ONLINE', '3年', 4.8, '林', '精通日料知识，服务周到');

-- 插入店员技能
INSERT INTO staff_skills (staff_id, skill_name) VALUES
(1, '菜品推荐'),
(1, '过敏咨询'),
(1, '口味调整'),
(1, '订座服务'),
(2, '客户投诉处理'),
(2, '团队管理'),
(2, '菜品推荐'),
(3, '粤菜知识'),
(3, '茶艺服务'),
(4, '西餐礼仪'),
(4, '红酒知识'),
(5, '日料知识'),
(5, '清酒推荐');

-- 插入店员语言
INSERT INTO staff_languages (staff_id, language) VALUES
(1, '中文'),
(1, '英文'),
(2, '中文'),
(3, '中文'),
(3, '粤语'),
(4, '中文'),
(4, '英文'),
(5, '中文'),
(5, '日语');

-- 插入评论数据
INSERT INTO reviews (restaurant_id, user_id, rating, comment, helpful_count) VALUES
(1, 1, 5, '菜品非常好吃，服务也很周到，强烈推荐！', 5),
(1, 2, 4, '环境不错，菜品口味正宗，就是有点辣', 3),
(1, 3, 5, '服务态度很好，推荐菜品很专业', 2),
(2, 1, 4, '点心很精致，服务也不错', 1),
(2, 2, 5, '烧腊味道很正宗，价格合理', 4),
(3, 3, 4, '环境浪漫，适合约会，菜品口味不错', 2),
(4, 1, 5, '刺身非常新鲜，服务很专业', 3);

-- 插入评论回复
INSERT INTO review_replies (review_id, content) VALUES
(1, '感谢您的评价，我们会继续努力提供更好的服务！'),
(3, '谢谢您的认可，我们会继续保持专业服务水准！'),
(5, '很高兴您喜欢我们的烧腊，期待您的再次光临！');

-- 插入店员评论
INSERT INTO staff_reviews (staff_id, user_id, rating, content) VALUES
(1, 1, 5.0, '小张服务很热情，推荐的菜品都很合口味'),
(1, 2, 4.5, '服务态度很好，对菜品了解很深入'),
(3, 3, 4.8, '小王服务很细心，粤菜知识丰富'),
(5, 1, 5.0, '小林对日料很有研究，服务专业周到');

-- 插入聊天会话
INSERT INTO chat_sessions (restaurant_id, staff_id, user_id, last_message, last_message_time, unread_count) VALUES
(1, 1, 1, '您好！很高兴为您服务', '2024-01-15 10:30:00', 2),
(2, 3, 1, '有什么可以帮助您的吗？', '2024-01-15 09:15:00', 0),
(4, 5, 2, '欢迎光临和风料理', '2024-01-14 20:45:00', 1);

-- 插入聊天消息
INSERT INTO chat_messages (session_id, sender_id, sender_type, content, is_read) VALUES
(1, 1, 'STAFF', '您好！很高兴为您服务。请问有什么可以帮助您的吗？', TRUE),
(1, 1, 'USER', '你好，我想了解一下你们店的特色菜品', TRUE),
(1, 1, 'STAFF', '我们的招牌菜有宫保鸡丁、鱼香肉丝和麻婆豆腐，这些都是很受欢迎的菜品。您有什么特别的口味偏好吗？', FALSE),
(1, 1, 'STAFF', '另外我们最近推出了新的水煮鱼，也很受欢迎哦！', FALSE),
(2, 3, 'STAFF', '有什么可以帮助您的吗？', TRUE),
(2, 1, 'USER', '我想预订今晚的座位', TRUE),
(2, 3, 'STAFF', '好的，请问几位？什么时间？', TRUE),
(3, 5, 'STAFF', '欢迎光临和风料理', FALSE),
(3, 2, 'USER', '你们店的刺身新鲜吗？', TRUE);

-- 更新餐厅评分和评论数量
UPDATE restaurants r
SET rating = (
    SELECT AVG(rating)
    FROM reviews
    WHERE restaurant_id = r.id
),
review_count = (
    SELECT COUNT(*)
    FROM reviews
    WHERE restaurant_id = r.id
);

-- 更新店员评分
UPDATE staff s
SET rating = (
    SELECT AVG(rating)
    FROM staff_reviews
    WHERE staff_id = s.id
);

-- 创建数据库用户（生产环境建议使用专用用户）
-- CREATE USER 'tabletalk_user'@'%' IDENTIFIED BY 'secure_password_123';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON tabletalk.* TO 'tabletalk_user'@'%';
-- FLUSH PRIVILEGES;

-- 创建数据库视图（可选）
CREATE VIEW restaurant_summary AS
SELECT
    r.id,
    r.name,
    r.type,
    r.rating,
    r.review_count,
    r.is_open,
    COUNT(DISTINCT s.id) as staff_count
FROM restaurants r
LEFT JOIN staff s ON r.id = s.restaurant_id
GROUP BY r.id, r.name, r.type, r.rating, r.review_count, r.is_open;

-- 创建存储过程（可选）
DELIMITER //

CREATE PROCEDURE GetRestaurantStats(IN restaurant_id BIGINT)
BEGIN
    SELECT
        r.name,
        r.rating,
        r.review_count,
        COUNT(DISTINCT s.id) as staff_count,
        COUNT(DISTINCT rd.id) as dish_count
    FROM restaurants r
    LEFT JOIN staff s ON r.id = s.restaurant_id
    LEFT JOIN recommended_dishes rd ON r.id = rd.restaurant_id
    WHERE r.id = restaurant_id
    GROUP BY r.name, r.rating, r.review_count;
END //

DELIMITER ;

-- 创建触发器（可选）
DELIMITER //

CREATE TRIGGER after_review_insert
AFTER INSERT ON reviews
FOR EACH ROW
BEGIN
    UPDATE restaurants
    SET rating = (
        SELECT AVG(rating)
        FROM reviews
        WHERE restaurant_id = NEW.restaurant_id
    ),
    review_count = (
        SELECT COUNT(*)
        FROM reviews
        WHERE restaurant_id = NEW.restaurant_id
    )
    WHERE id = NEW.restaurant_id;
END //

DELIMITER ;

-- 数据库配置优化建议
-- 在 my.cnf 或 my.ini 中添加以下配置：
/*
[mysqld]
# 字符集配置
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci

# 连接配置
max_connections=1000
wait_timeout=600
interactive_timeout=600

# 缓冲池配置（根据服务器内存调整）
innodb_buffer_pool_size=1G
innodb_log_file_size=256M

# 其他优化
innodb_flush_log_at_trx_commit=1
sync_binlog=1
*/

-- 数据库备份脚本示例
/*
#!/bin/bash
# 数据库备份脚本
BACKUP_DIR="/backup/mysql"
DATE=$(date +%Y%m%d_%H%M%S)
DB_NAME="tabletalk"

mysqldump -u root -p $DB_NAME > $BACKUP_DIR/${DB_NAME}_${DATE}.sql
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
*/

-- 完成提示
SELECT 'TableTalk 数据库初始化完成!' AS message;