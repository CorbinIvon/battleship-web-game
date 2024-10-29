-- CreateTable
CREATE TABLE `users` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `last_login` DATETIME(3) NULL,
    `username` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `password_hash` VARCHAR(191) NOT NULL,
    `games_played` INTEGER NOT NULL DEFAULT 0,
    `games_won` INTEGER NOT NULL DEFAULT 0,
    `games_lost` INTEGER NOT NULL DEFAULT 0,
    `games_forfeit` INTEGER NOT NULL DEFAULT 0,
    `profile_picture_url` VARCHAR(191) NULL,
    `status` ENUM('ONLINE', 'OFFLINE', 'IN_GAME') NOT NULL DEFAULT 'OFFLINE',

    UNIQUE INDEX `users_username_key`(`username`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `leaderboards` (
    `leaderboard_id` INTEGER NOT NULL AUTO_INCREMENT,
    `updated_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `user_id` INTEGER NOT NULL,
    `rank` INTEGER NOT NULL,
    `total_score` INTEGER NOT NULL DEFAULT 0,
    `total_wins` INTEGER NOT NULL DEFAULT 0,
    `total_games` INTEGER NOT NULL DEFAULT 0,
    `win_ratio` DOUBLE NOT NULL DEFAULT 0,

    UNIQUE INDEX `leaderboards_user_id_key`(`user_id`),
    PRIMARY KEY (`leaderboard_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `games` (
    `game_id` INTEGER NOT NULL AUTO_INCREMENT,
    `player1_id` INTEGER NOT NULL,
    `player2_id` INTEGER NOT NULL,
    `winner_id` INTEGER NULL,
    `start_time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `end_time` DATETIME(3) NULL,

    INDEX `games_player1_id_idx`(`player1_id`),
    INDEX `games_player2_id_idx`(`player2_id`),
    INDEX `games_winner_id_idx`(`winner_id`),
    PRIMARY KEY (`game_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `moves` (
    `move_id` INTEGER NOT NULL AUTO_INCREMENT,
    `game_id` INTEGER NOT NULL,
    `player_id` INTEGER NOT NULL,
    `coordinate_x` INTEGER NOT NULL,
    `coordinate_y` INTEGER NOT NULL,
    `hit` BOOLEAN NOT NULL,
    `timestamp` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `moves_game_id_idx`(`game_id`),
    INDEX `moves_player_id_idx`(`player_id`),
    PRIMARY KEY (`move_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `game_settings` (
    `setting_id` INTEGER NOT NULL AUTO_INCREMENT,
    `game_id` INTEGER NOT NULL,
    `board_size_x` INTEGER NOT NULL DEFAULT 10,
    `board_size_y` INTEGER NOT NULL DEFAULT 10,
    `max_ships` INTEGER NOT NULL DEFAULT 5,
    `turn_time_limit` INTEGER NULL,

    UNIQUE INDEX `game_settings_game_id_key`(`game_id`),
    INDEX `game_settings_game_id_idx`(`game_id`),
    PRIMARY KEY (`setting_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `boards` (
    `board_id` INTEGER NOT NULL AUTO_INCREMENT,
    `game_id` INTEGER NOT NULL,
    `player_id` INTEGER NOT NULL,
    `layout` JSON NOT NULL,
    `hits` JSON NOT NULL,
    `sunk_ships` INTEGER NOT NULL DEFAULT 0,

    INDEX `boards_game_id_idx`(`game_id`),
    INDEX `boards_player_id_idx`(`player_id`),
    PRIMARY KEY (`board_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ships` (
    `ship_id` INTEGER NOT NULL AUTO_INCREMENT,
    `board_id` INTEGER NOT NULL,
    `type` ENUM('CARRIER', 'BATTLESHIP', 'DESTROYER', 'SUBMARINE', 'PATROL_BOAT') NOT NULL,
    `coordinates` JSON NOT NULL,
    `sunk` BOOLEAN NOT NULL DEFAULT false,

    INDEX `ships_board_id_idx`(`board_id`),
    PRIMARY KEY (`ship_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `lobbies` (
    `lobby_id` INTEGER NOT NULL AUTO_INCREMENT,
    `host_user_id` INTEGER NOT NULL,
    `game_id` INTEGER NOT NULL,
    `player_count` INTEGER NOT NULL,
    `invite_code` VARCHAR(191) NOT NULL,
    `public` BOOLEAN NOT NULL DEFAULT true,

    INDEX `lobbies_host_user_id_idx`(`host_user_id`),
    INDEX `lobbies_game_id_idx`(`game_id`),
    PRIMARY KEY (`lobby_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ShipToUser` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_ShipToUser_AB_unique`(`A`, `B`),
    INDEX `_ShipToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
